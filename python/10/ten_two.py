def read_lines():
    with open('input.txt') as file:
        lines = [line.rstrip() for line in file]
        return lines


cycle_break_points = [40, 80, 120, 160, 200, 240]

cycle_counter = 0
x = 1

crt_position = 0

answer = ''

def spriteIsOnCRT():
    return x == crt_position or x + 1 == crt_position or x - 1 == crt_position

def drawPixel():
    if spriteIsOnCRT():
        return '🌝'
    else: 
        return '🌚'

for line in read_lines():


    answer += drawPixel()

    cycle_counter+=1
    crt_position += 1

    if cycle_counter in cycle_break_points:  
        answer += '\n'
        crt_position = 0

    if line != 'noop':
        answer += drawPixel()

        cycle_counter+=1
        crt_position += 1


        if cycle_counter in cycle_break_points:
            answer += '\n'
            crt_position = 0

        x += int(line.split()[1])
        

print(answer) 

