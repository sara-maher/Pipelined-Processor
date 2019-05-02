import opcodes as op

def writeFile(translated_code):
    f = open("mem.txt", "w")
    for i in range(len(translated_code)):
        print(i,translated_code[i]) 
        #f.write(str(i) + " "+str(translated_code[i])+'\n') #modify
        f.write(str(translated_code[i])+'\n')
    f.close()

def convertToBin(num, n):
   decimalNum = int(num, 16)
   binaryNum = bin(decimalNum)[2:]
   s = ''
   print("lenbin: ", len(str(binaryNum)) , " n: ", n)
   for k in range(0, n-len(str(binaryNum))):    
     s += '0'
     
   return s+binaryNum

def assembler(translated_code):
    assembled = ''
    source_code=open("Memory.asm",'r')
    lines = source_code.readlines()
    j = 0
    immediateflag = False
    LDMFlag = False
    Flag = False
    immediateVal = 0
    
    for ln in lines:
        code = ln.split('#')
        l = code[0].replace(","," ")
        l = l.split()
        print(l)
        i = 0
        
        if( len(l) == 0): #empty line
            continue
        
        while(i < len(l)):
            if(l[i].upper() == '.ORG'):
                #if( address < len(translated_code)):
                 #   print("invalid Address")
                address = int(l[i+1], 16) #convert to decimal
                for k in range (len(translated_code), address):
                    translated_code.append("0000000000000000")
                    #translated_code.append("0")
                i += 2
                Flag = True
                print(translated_code)
                break
            
            if (j == 1): #M[0]
                num = convertToBin(l[i],16)
                translated_code.append(num)
                i += 1
                print(translated_code)
                Flag = True
                continue
            
            if(j == 3):#M[1]
                num = convertToBin(l[i],16)
                translated_code.append(num)
                i += 1
                print(translated_code)
                Flag = True
                continue 
            
            if (i == 0):
                try:   
                    instruction_code=op.Opcodes[l[i].upper()] 
                    if(l[i].upper() == 'LDM'):
                        LDMFlag = True
                    if(l[i].upper() == 'SHL' or l[i].upper() == 'SHR'):
                        immediateflag = True
                    
                except:
                    print("instruction "+l[i]+" not found !!")
                    return
                assembled += instruction_code
                print("instrcode: ", assembled)
                
            elif(i == 1):
                try:   
                    register_code=op.Register[l[i].upper()] 
                    
                except:
                    print("register "+l[i]+" not found !!")
                    return
                assembled += register_code
                
            elif(i == 2):
                if(LDMFlag):
                    immediateVal = convertToBin(l[i], 16)
                    
                elif(immediateflag):
                    num = convertToBin(l[i], 7)
                    assembled += num
                    
                else:    
                    try:   
                        register_code=op.Register[l[i].upper()] 
                        
                    except:
                        print("register "+l[i]+" not found !!")
                        return
                    assembled += register_code
            i += 1
            print(translated_code)
            
        if(not Flag):
           for k in range(len(assembled), 16):
               assembled += "0"
           translated_code.append(assembled)
           if(LDMFlag):
               translated_code.append(immediateVal)
           #NOP operation #remove after handling Data Hazard
           #Modify
           for k in range(0,3):
               translated_code.append("0000000000000000") 
               
        LDMFlag = False
        immediateflag = False
        assembled=''
        Flag = False
        j += 1
            
translated_code = []
assembler(translated_code)
writeFile(translated_code)