# -----------------------------------------------------------------------------
# $Id: File.pm 11365 2008-05-10 14:58:28Z topia $
# -----------------------------------------------------------------------------
# copyright (C) 2004 Topia <topia@clovery.jp>. all rights reserved.
package Log::Writer::File;
use strict;
use warnings;
use IO::File;
use File::Spec;
use Module::Use qw(Log::Writer::Base);
use base qw(Log::Writer::Base);
use File::Path;

sub new {
    my ($class, $parent, $uri, %options) = @_;
    my $this = $class->SUPER::new($parent, $uri, %options);

    $this->{file_mode} = $this->first_defined($options{file_mode},
				       _oct($options{file_mode_oct}),
				       0600);
    $this->{dir_mode} = $this->first_defined($options{dir_mode},
				      _oct($options{dir_mode_oct}),
				      0700);

    $this;
}

sub capability {
    my ($class, $type, @args) = @_;

    my $supported = $class->SUPER::capability($type, @args);
    return 1 if $supported;
    if ($type eq 'fallback') {
	return 1;
    }
    return 0;
}

sub _file {
    my $this = shift;

    if (!defined $this->{file}) {
	$this->mkdirs($this->path);
	$this->path =~ /^(.+)$/; # untaint
	$this->{file} = IO::File->new($1,
				      O_CREAT | O_APPEND | O_WRONLY,
				      $this->file_mode);
    }
    $this->{file};
}

sub scheme {
    'file';
}
*name = \&scheme;
*supported_schemes = \&scheme;

__PACKAGE__->define_attr_accessor(0, qw(file_mode dir_mode));

sub real_flush {
    my $this = shift;

    my $file = $this->_file;
    if (!defined $file) {
	$this->_notify_warn('can\'t open file');
	return 0;
    }

    my $ret = 0;
    my $size = 1;
    while ($size && $this->has_data) {
	# use buffer directly; perhaps reduce memory allocation
	$size = $file->syswrite($this->{buffer}, $this->length);
	if (defined $size) {
	    substr($this->{buffer}, 0, $size) = '';
	    $ret = 1;
	} else {
	    $this->_notify_warn($!);
	}
    }
    return $ret;
}

sub real_destruct {
    my ($this, $force) = @_;

    # make useless efforts
    $this->real_flush;

    if (!defined $this->has_data) {
	$this->_notify_warn('has can\'t flush data; will lost!');
    }
    if (defined $this->{file}) {
	# not use ->file. we don't need new allocation.
	$this->{file}->close;
    }
    return 1;
}

sub _oct {
    map { defined $_ ? oct("0$_") : undef } @_;
}

sub mkdirs {
    my ($this,$file) = @_;
    my (undef,$directories,undef) = File::Spec->splitpath($file);

    # 直接の親が存在するか
    if ($directories eq '' || -d $directories) {
	# これ以上辿れないか、存在するので終了。
	return;
    }
    else {
	# 存在しないので作成
	eval { mkpath($directories, 0, $this->dir_mode) };
	if ($@) {
	    $this->_notify_warn("mkpath failed; Couldn't create $directories: $@");
	}
    }
}

1;
