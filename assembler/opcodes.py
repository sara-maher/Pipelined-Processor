
# you give it the operation and it returns the binary code of it
Opcodes = {
        'NOP': '000000',
        'SETC':'000001',
        'CLRC':'000010',
        'NOT': '000011',
        'INC': '000100',
        'DEC': '000101',
        'OUT': '100110',
        'IN':  '100111',
        
        'MOV': '001000',
        'ADD': '001001',
        'SUB': '001010',
        'AND': '001011',
        'OR' : '001100',
        'SHL': '001101',
        'SHR': '001110',
        
        'PUSH': '101111',
        'POP': '110000',
        'LDM': '110001',
        'LDD': '110010',
        'STD': '110011',
        
        'JZ': '010100',
        'JN': '010101',
        'JC': '010110',
        'JMP': '010111',
        'CALL': '111000',
        'RET': '111001',
        'RTI': '111010',
        
        'RESET': '111011',
        'INTERRUPT': '111100'
        }

Register={
        'R0':'000',
        'R1':'001', 
        'R2':'010',
        'R3':'011',
        'R4':'100',
        'R5':'101',
        'R6':'110',
        'R7':'111'
        }


