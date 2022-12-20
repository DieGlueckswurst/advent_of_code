import re

class Monkey:
  def __init__(self, items, operation, test, trueNext, falseNext):
    self.items = items
    self.operation = operation
    self.test = test
    self.trueNext = trueNext
    self.falseNext = falseNext

def read_lines():
    with open('input.txt') as file:
        lines = [line.rstrip() for line in file]
        return lines

monkeys = []

plus = '+'
multiply = '*'


def getMonkeys():
    monkeys = []
    starting = []
    operation = ''
    test = 0
    trueNext = 0
    falseNext = 0

    lines = read_lines()
    for line in lines:

        if line.strip().startswith('Starting'):
            itemStrings = re.findall(r'\d+', line)
            itemInts = []
            for item in itemStrings: 
                itemInts.append(int(item))
            starting = itemInts
        if line.strip().startswith('Operation'):
            if plus in line:
                operation += plus
            if multiply in line:
                operation += multiply
            number = line.split()[-1]
            operation += ' ' + number
        if line.strip().startswith('Test'):
            test = int(re.findall(r'\d+', line)[0])
        if line.strip().startswith('If true'):
            trueNext = int(re.findall(r'\d+', line)[0])
        if line.strip().startswith('If false'):
            falseNext = int(re.findall(r'\d+', line)[0])

        # Added "END" to the end of the input file to easily know the end of the file
        if line.strip() == '' or line == 'END':
            monkeys.append(Monkey(starting, operation, test, trueNext, falseNext))
            starting = []
            operation = ''
            test = 0
            trueNext = 0
            falseNext = 0     

    return monkeys


monkeys = getMonkeys()

monkeyVisitedItems = {}

def fillVisited():
    for i in range(len(monkeys)):
        monkeyVisitedItems[i] = 0
  
fillVisited()
rounds = 10000

for r in range(rounds):
    i = 0
    print(r)
    for monkey in monkeys:
        # print(monkey.items)
        itemsLen = len(monkey.items) 
        for itemIndex in range(itemsLen):
            # print(itemIndex)
            worry_level = monkey.items[itemIndex]
            # print(monkey.operation.split())
            number = monkey.operation.split()[1]
            if number == 'old':
                number = worry_level  
            if plus in monkey.operation:
                worry_level += int(number)
            if (multiply) in monkey.operation:
                worry_level *= int(number)
            # worry_level = int(worry_level/3)
            if worry_level % monkey.test == 0:
                monkeys[monkey.trueNext].items.append(worry_level)
            else: 
                monkeys[monkey.falseNext].items.append(worry_level)
            
       
        monkeyVisitedItems[i] += itemsLen
        monkeys[i].items = []
        
        i += 1


visitedItems = []
for key in monkeyVisitedItems:
    visitedItems.append(monkeyVisitedItems[key])

visitedItems.sort()

max1 = visitedItems[len(visitedItems) -2]
max2 = visitedItems[len(visitedItems) -1]

print(max1 * max2)




            
                

