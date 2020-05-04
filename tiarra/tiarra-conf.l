;;; -*- Mode: Lisp; Package: EDITOR -*-

;; $Id: tiarra-conf.l 8435 2008-03-27 03:20:36Z elim $

;;tiarra-conf.l (tiarra-conf.el�̈ڐA)
;;Copyright (C) 2003 Noboruhi

;;Author: Noboruhi
;;Version: 0.0.0.1

;; �g����:

;; 1. tiarra-conf.l(���̃t�@�C��)��(xyzzy���C���X�g�[�������f�B���N�g��)/site-lisp/ �ɃR�s�[
;; 2. �K�v��������o�C�g�R���p�C��
;; 3. ���W���[���o�^����B
;;     [.xyzzy �̏ꍇ]
;;         (export 'ed::tiarra-conf-mode "ed")
;;         (autoload 'tiarra-conf-mode "tiarra-conf" t)
;;     [siteinit.l�̏ꍇ]
;;         (in-package "editor")
;;         (export 'tiarra-conf-mode)
;;         (autoload 'tiarra-conf-mode "tiarra-conf" t)
;;         (in-package "user")
;; 4.xyzzy���ċN��

;; �J�X�^�}�C�Y:

;; �F�̕ύX
;;   (setq ed::*tiarra-conf-font-lock-comment-face* '(:comment))
;;   (setq ed::*tiarra-conf-font-lock-warning-face* '((:keyword :comment :bold)))
;;   (setq ed::*tiarra-conf-font-lock-type-face* '((:keyword 0)))
;;   (setq ed::*tiarra-conf-font-lock-constant-face* '((:keyword 2)))
;;   (setq ed::*tiarra-conf-font-lock-variable-face* '(:color 11 0))
;;   (setq ed::*tiarra-conf-font-lock-string-face* ':string)
;;   (setq ed::*tiarra-conf-font-lock-function-name-face* '((:keyword 1)))

;; Changes:
;;   [Version 0.0.0.1]
;;   �E���ŁB���������Ȃ��A���������Ȃ��B
;;   

(provide "tiarra-conf-mode")
(in-package "editor")

;; �L�[�}�b�v
(defvar *tiarra-conf-mode-map* nil
  "Keymap for tiarra conf mode.")


(unless *tiarra-conf-mode-map*
  (setq *tiarra-conf-mode-map* (make-sparse-keymap)))

;; �\����`
(defvar *tiarra-conf-mode-syntax-table* nil
  "Syntax table used while in tiarra conf mode.")
(unless *tiarra-conf-mode-syntax-table*
  (setq *tiarra-conf-mode-syntax-table* (make-syntax-table))
  (set-syntax-match *tiarra-conf-mode-syntax-table* #\{ #\}))


;; �����`
(defvar *tiarra-conf-mode-abbrev-table* nil
  "Abbrev table used while in tiarra conf mode.")
(unless *tiarra-conf-mode-abbrev-table*
  (define-abbrev-table '*tiarra-conf-mode-abbrev-table*))


;; �t�b�N
(defvar *tiarra-conf-mode-hook* nil
  "Normal hook runs when entering tiarra-conf-mode.")

;; �t�H���g���b�N�̐ݒ�
(defvar *tiarra-conf-font-lock-comment-face* '(:comment))
(defvar *tiarra-conf-font-lock-warning-face* '((:keyword :comment :bold)))
(defvar *tiarra-conf-font-lock-type-face* '((:keyword 0)))
(defvar *tiarra-conf-font-lock-constant-face* '((:keyword 2)))
(defvar *tiarra-conf-font-lock-variable-face* '(:color 11 0))
(defvar *tiarra-conf-font-lock-string-face* ':string)
(defvar *tiarra-conf-font-lock-function-name-face* '((:keyword 1)))

(defvar *tiarra-conf-regexp-keyword-list*
  (compile-regexp-keyword-list
   `(
     ("^[\t ]*#.*$" nil . ,*tiarra-conf-font-lock-comment-face*)
     ("^[\t ]*@.*$" nil . ,*tiarra-conf-font-lock-warning-face*)
     ("^[\t ]*\\+[\t ]+.+$" nil . ,*tiarra-conf-font-lock-type-face*)
     ("^[\t ]*-[\t ]+.+$" nil . ,*tiarra-conf-font-lock-constant-face*)
     ("^[\t ]*\\([^:\n]+\\)\\(:\\).*$" nil ((1 . ,*tiarra-conf-font-lock-variable-face*)
					    (2 .  ,*tiarra-conf-font-lock-string-face*)))
     ("^[\t ]*[^{}\n]+" nil . ,*tiarra-conf-font-lock-function-name-face*)
     )))




;;
(defun tiarra-conf-mode ()
  "Major mode for editing tiarra conf file.
\\{*tiarra-conf-mode-map*}
Turning on tiarra-conf-mode runs the normal hook `tiarra-conf-mode-hook'."
  (interactive)
  (kill-all-local-variables)
  (setq mode-name "tiarra-conf")
  (setq buffer-mode 'tiarra-conf-mode)
  (use-keymap *tiarra-conf-mode-map*)
  (use-syntax-table *tiarra-conf-mode-syntax-table*)
  (setq *local-abbrev-table* *tiarra-conf-mode-abbrev-table*)
  (make-local-variable 'regexp-keyword-list)
  (setq regexp-keyword-list *tiarra-conf-regexp-keyword-list*)
  (run-hooks '*tiarra-conf-mode-hook*))

