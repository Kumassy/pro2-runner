require 'stringio'
require 'yaml'

# data javajava {
#   filename :: String
#   build :: String
#   run :: String
# }

# prefix: X for ProbXY.java
# num_file: Y for ProbXY.java
# Int -> Int -> javajava
def initialize_project(prefix, num_file)
  javajava = []
  1.upto(num_file) do |i|
    filename = "Prob#{prefix}#{i}"
    javajava.push({
      'filename' => "#{filename}.java",
      'build' => "javac #{filename}.java",
      'run' => "java #{filename}",
    })
  end
  javajava
end

# :: javajava
def parse_project
  yaml = File.read('project.yaml')
  YAML.load yaml
end

# String -> String
def generate_java(filename)
  class_name = File.basename(filename, '.java')

  content =
%(public class #{class_name} {
  public static void main(String[] args) {
    System.out.println("Hello World!");
  }
})
end

# javajava -> (Java files)
def generate_empty_javajava(javajava)
  javajava.each do |java|
    filename = java.fetch('filename')
    file_write!(filename, generate_java(filename))
  end
end

# filename :: String -> content :: String -> (File write)
def file_write!(filename, content)
  raise "#{filename} already exist!" if File.exists? filename
  File.write(filename, content)
end

# Int -> Int -> (project.yaml)
def command_init(prefix, num_file)
  project_file = 'project.yaml'

  javajava = initialize_project(prefix, num_file)
  file_write!(project_file, javajava.to_yaml)
  generate_empty_javajava(javajava)
end

def command_build
  
end


# pro2 init -> generate project.yml
# pro2 build -> compile entries
# pro2 execute -> execute entries
# pro2 run -> compile & execute entries
# pro2 lint -> linter
