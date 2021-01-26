(in-package :nyxt-user)

(define-parenscript %percentage ()
  (defun percentage ()
    (let* ((height-of-window (ps:@ window inner-height))
           (content-scrolled (ps:@ window page-y-offset))
           (body-height (ps:chain window
                                  document
                                  (get-elements-by-tag-name "body")
                                  0
                                  offset-height))
           (total (- body-height height-of-window))
           (prc (* (/ content-scrolled total) 100)))
      (if (> prc 100)
          100
          (round prc))))
  (percentage))

(define-command percentage ()
  "Print percentage to minibuffer, then return the value."
  (echo (%percentage))
  (%percentage))

(hooks:add-hook nyxt/web-mode:scroll-down-after-hook
                (hooks:make-handler-void #'percentage))
(hooks:add-hook nyxt/web-mode:scroll-up-after-hook
                (hooks:make-handler-void #'percentage))
(hooks:add-hook nyxt/web-mode:scroll-to-top-after-hook
                (hooks:make-handler-void #'percentage))
(hooks:add-hook nyxt/web-mode:scroll-to-bottom-after-hook
                (hooks:make-handler-void #'percentage))
