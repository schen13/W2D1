class Employee
  attr_reader :name, :title, :salary, :boss
  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
  end

  def set_boss(boss)
    @boss = boss
  end
end

class Manager < Employee

  attr_reader :employees

  def initialize(name, title, salary, boss = nil, employees = [])
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    my_queue = @employees
    bonus = 0
    until my_queue.empty?
      employee = my_queue.shift
      bonus += employee.salary
      if employee.is_a?(Manager)
        employee.employees.each{|sub_emp| my_queue.push(sub_emp)}
      end
    end
    bonus *= multiplier
  end

  def add_employee(new_employee)
    @employees << new_employee
  end
end


shawna = Employee.new('Shawna', 'TA', 12_000)
david = Employee.new('David', 'TA', 10_000)

darren = Manager.new('Darren', 'TA', 78_000)
darren.add_employee(shawna)
darren.add_employee(david)
shawna.set_boss(darren)
david.set_boss(darren)

ned = Manager.new("Ned", "Founder", 1_000_000, nil)
ned.add_employee(darren)
darren.set_boss(ned)

p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000
