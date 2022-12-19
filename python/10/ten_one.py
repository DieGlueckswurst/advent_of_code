def read_lines():
    with open('input.txt') as file:
        lines = [line.rstrip() for line in file]
        return lines


cycle_break_points = [20, 60, 100, 140, 180, 220]

cycle_counter = 0
x = 1
sum_of_all_strenghts = 0


def get_strength(breakpoint):
    return breakpoint * x




for line in read_lines():
    cycle_counter+=1


    if cycle_counter in cycle_break_points:  
        sum_of_all_strenghts += get_strength(cycle_counter)

    if line != 'noop':
        cycle_counter+=1

        if cycle_counter in cycle_break_points:
            sum_of_all_strenghts += get_strength(cycle_counter)
   
        x += int(line.split()[1])
        

print(sum_of_all_strenghts) 

