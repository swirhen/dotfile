package Auto::Ignore;
use strict;
use warnings;
use base qw(Module);
use Mask;

sub message_arrived {
	my ($this,$msg,$sender) = @_;
	
	if ($sender->isa('IrcIO::Server') &&
		$msg->command eq 'PRIVMSG' &&
		Mask::match_array([$this->config->mask('all')],$msg->param(1), 1)) {
			return undef;
	}
	return $msg;
}

1;
