;; -*- mode: emacs-lisp -*-
;; Simple .emacs configuration

;; ---------------------
;; -- Global Settings --
;; ---------------------

(add-to-list 'load-path "~/emacs.d")

;; Add  custom theme load path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
;; Add solarized theme
(load-theme 'solarized t)

;; Add C/C++ mode by default
(require 'cc-mode)

;; Add code indentation
(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

;;(set-frame-parameter nil 'background-mode 'dark)
;;(set-terminal-parameter nil 'background-mode 'dark)
;;(setq solarized-use-termial-theme t)

;; Set the emacs BG trasparent, to keep the terminal blue BG
;; Not sure how correct this is
(custom-set-faces  '(default ((t (:background "transparent"))) t))

;;; Emacs is not a package manager, and here we load its package manager!
(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
				  ("elpa" . "http://tromey.com/elpa/")
				  ;; TODO: Maybe, use this after emacs24 is released
				  ;; (development versions of packages)
				  ("melpa" . "http://melpa.milkbox.net/packages/")
				  ))
  (add-to-list 'package-archives source t))
(package-initialize)

;;; Automatically Install Required Packages
;;; everytime emacs starts, it will automatically check if those packages are
;;; missing, it will install them automatically
;;; https://truongtx.me/2013/01/07/emacs-package-manager/
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar tmtxt/packages
  '(yasnippet auto-complete auto-complete-c-headers iedit flymake-google-cpplint flymake-cursor google-c-style irony))
(dolist (p tmtxt/packages)
  (when (not (package-installed-p p))
	    (package-install p)))

;; start yasnippet with emacs
(yas-global-mode 1)
;; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")
(setq ac-source-yasnippet nil)
;; let's define a function which initializes auto-complete-c-headers
;; and gets called for C/C++ hooks
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/Library/Developer/CommandLineTools/usr/bin/../lib/clang/6.0/include")
)
;; now let's call this function from c7c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)
;; fix iedit bug in Mac
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; start flymake-google-cppling-load
;; let's define a function for flymake initialization
(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
  (flymake-google-cpplint-load)
)
(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c++-mode-hook 'my:flymake-google-init)

;; start google-c-style with emacs
;; Indent at newline
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; turn Semantic
;; CEDET feature
;;-(semantic-mode 1)

;; Let's define a function which adds Semantic as a suggestion backend to auto-complete
;; and hook this function to c-mode-common-hook
;;-(defun my:add-semantic-to-autocomplete()
;;-  (add-to-list 'ac-sources 'ac-source-semantic)
;;-)
;;-(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

;; turn on ede mode
;;-(global-ede-mode 1)
;; create a project for our program.
;;-(ede-cpp-root-project "My project" :file "/Users/RicardoGaviria/Projects/learning-c++/src/main.cpp"
;;-					  :include-path '("/ ../my_inc"))
;;  you can now use system-include-path for settting up the system header file locations
;; turn on automatic reparsing of open buffers in semantic
;;-(global-semantic-idle-scheduler-mode 1)


(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
	'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
	'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; define a function to start irony mode for c/c++ modes
(defun my:irony-enable()
  (when (member major-mode irony-known-modes)
	(irony-mode 1)))
(add-hook 'c++-mode-hook 'my:irony-enable)
(add-hook 'c-mode-hook 'my:irony-enable)

