with open('repos.txt') as file:
    content = file.readlines()
    repo_name = []
    for i in content:
        repo_name.append(i.split('/')[-1])

print(repo_name[0])
        
with open('repos1.txt', 'w+') as file1:
    for i in repo_name:
        file1.write(i)
        