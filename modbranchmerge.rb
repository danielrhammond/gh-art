require 'digest/md5'

def branch(name)
  system("git branch #{name}")
end

def checkout(name)
  system("git checkout #{name}")
end

def delete(name)
  system("git branch -d #{name}")
end

def mod
  File.open("data",'a+') {|f| f.write(Time.now)}
end

def commit
  sleep(1)
  system("git commit -am '.'")
end

def merge(name)
  system("git merge #{name}")
end

def modbranchmerge(name,many)
  branches = []
  many.times do
    newbranch = Digest::MD5.hexdigest(Time.now.to_s)
    branches << newbranch
    sleep(1)
  end
  branches.each do |b|
    branch(b)
  end
  branches.each do |b|
    checkout(b)
    File.open(b,'a+') {|f| f.write(Time.now)}
    system("git add .")
    commit
    checkout(name)
  end
  sleep(1)
  branches.reverse.each do |b|
    checkout(b)
    File.open(b,'a+') {|f| f.write(Time.now)}
    system("git add .")
    commit
    checkout(name)    
  end
  checkout(name)
  File.open("data2",'a+') {|f| f.write(Time.now)}
  commit
  branches.each do |b| 
    merge(b)
    commit
    delete(b)
  end
  
  
end
modbranchmerge("master",100)