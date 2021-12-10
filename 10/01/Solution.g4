grammar Solution;		
expr:	('(') expr (')')
    |	('[') expr (']')
    |   ('<') expr ('>')
    |   ('{') expr ('}')
    |   expr (EOF|'\n')
    ;
