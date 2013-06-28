(define (compile-variable exp target linkage c-env)
    (let ((lex-addr (find-variable exp c-env)))
        (if (eq? lex-addr 'not-found)
            (compile-normal-lookup exp linkage)
            (end-with-linkage linkage
                (make-instruction-sequence '(env) (list target)
                    `((assign ,target
                              (op lexical-address-lookup)
                              (reg env)
                              (const ,lex-addr))))))))

(define (compile-normal-lookup exp linkage)
  (end-with-linkage linkage
   (make-instruction-sequence '(env) (list target)
    `((assign ,target
              (op lookup-variable-value)
              (const ,exp)
              (reg env))))))

(define (compile-assignment exp target linkage c-env)
    (let ((var (assignment-variable exp))
          (get-value-code (compile (assignment-value exp) 'val 'next c-env)))
        (let ((lex-addr (find-variable var c-env)))
            (if (eq? lex-addr 'not-found)
                (compile-normal-assignment exp target linkage c-env)
                (end-with-linkage linkage
                 (preserving '(env)
                  get-value-code
                  (make-instruction-sequence '(env val) (list target)
                   `((perform (op lexical-address-set!)
                              (reg env)
                              (const ,lex-addr)
                              (reg val))
                     (assign ,target (const ok))))))))))

(define (compile-normal-assignment exp target linkage c-env)
  (let ((var (assignment-variable exp))
        (get-value-code
         (compile (assignment-value exp) 'val 'next c-env)))
    (end-with-linkage linkage
     (preserving '(env)
      get-value-code
      (make-instruction-sequence '(env val) (list target)
       `((perform (op set-variable-value!)
                  (const ,var)
                  (reg val)
                  (reg env))
         (assign ,target (const ok))))))))
