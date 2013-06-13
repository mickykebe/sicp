(controller
    fact-start
    (assign product (const 1))
    (assign counter (const 1))
    test-n
    (test (op >) (reg counter) (reg n))
    (branch (label fact-done))
    (assign x (op mul) (reg product) (reg counter))
    (assign y (op inc) (reg counter) (const 1))
    (assign product (reg x))
    (assign counter (reg y))
    (goto (label test-n))
    fact-done)
