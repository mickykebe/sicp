;explicit dispatch
    ;Adding new type
        ;Tagging data objects
        ;Beyond the operations added for the type, each generic selector is also modified to take into account the new type
        ;Care also must be made to ensure the uniqueness of the operations' names

    ;Adding new operation
        ;Beyond all the version of operations added for each type, a new generic selector is needed for the operation
        ;Again name conflicts of operations between d/t types must be avoided

;data-directed style
    ;Adding new type
        ;Tagging new objects
        ;Beyond the operations of the type, the other addition necessary is that of entries of the type along with it's procedures to the dispatch table

    ;Adding new operation
        ;Defining versions of the operation for each type, each subsequently added to the dispatch table

;message-passing-style
    ; Adding new type
        ; Adding a data object encapsulating the dispatch logic for each operation

    ;Adding new operation
        ; Modifying each data object by adding the dispatch logic for the new operation

;Explicit dispatch is not an improvement on the alternative flavours on both considerations and thus will not be a subject in discussion below.

; For a system where new types are often added a message-passing flavour would be a slight improvement on the data-directed style as it avoids the tagging of new objects and the addition of each operation for the type into a dispatch table.

; For a system where new operations are often added a data-directed style would trump all alternatives as it only requires the addition of the operation to a dispatch table. A message-passing style, as it requires the modification of data objects is less desirable.
