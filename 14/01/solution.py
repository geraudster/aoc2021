with open('input_test') as f:
    template = f.readline().replace('\n', '')
    f.readline()  # empty line
    pair_insertion = {parts[0]: f"{parts[1]}".replace('\n', '') for parts in [line.split(' -> ') for line in f.readlines()]}

print(pair_insertion)
result = [l for l in template]
print(result)
