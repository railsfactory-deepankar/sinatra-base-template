
class Todolist
attr_accessor :filename,:todo,:completed,:pending

def initialize(filename)
@filename = filename
@todo = []
@completed = []
@pending = []
end

def pending
  @pending
end

def list
@todo = @pending + @completed
 @todo
end

def completed
 @completed
end

def add(items)
@todo << items
@pending << items + " #undone"
@pending
end

def complete(num1)
num = num1.to_i
@completed << @pending[num - 1]
for i in 0...@completed.size
@completed[i].gsub!(/#undone/,'#done')
end
@pending.delete_at(num - 1)
@completed
end

def delete(num)
@completed.delete_at(num-1)
 @completed
end

def modify(num , item)
@pending[num-1] = item
 return @pending[num - 1]
end

def empty
@pending.clear
@completed.clear
@todo.clear
return true
end

def show_pending(num)
return @pending[num-1]
end

def show_completed(num)
return @completed[num-1]
end

def save
f = File.open(@filename, "w")
str =""
str = @todo.join("\n")
f.write(str)
f.close
count = 0
File.open(filename) {|f| count = f.read.count("\n")}
count+1
end

def load1
   f = File.open(@filename,'r')
   f.each_line { |line| todo << line.strip }
   @completed = @todo.select {|c| c.match("#done")}
    @pending = @todo - @completed
    
end
def save_to_file(filename)
	f = File.open(filename, "w")
	str = ""
	str = @todo.join("\n")
	f.write(str)
	f.close
	count = 0
	File.open(filename) {|f| count = f.read.count("\n")}
	count+1
end
def load_from_file(filename)
   f = File.open(filename,'r')
   f.each_line { |line| todo << line.strip }
   @completed = @todo.select {|c| c.match("#done")}
    @pending = @todo - @completed
    
end

end
