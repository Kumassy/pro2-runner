require 'yaml'

module Pro2
  class << self
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
    def parse_project!
      project_file = 'project.yaml'
      raise "#{project_file} not found!! Run `pro2 init`" unless File.exists? project_file
      yaml = File.read(project_file)
      YAML.load yaml
    end

    # javajava -> filter -> javajava
    def filter_javajava(javajava, filter)
      javajava.select {|java| java.fetch('filename') == filter}
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

    def command_build(filter = nil)
      javajava = parse_project!
      javajava = filter_javajava(javajava, filter) if filter
      javajava.each do |java|
        filename = java.fetch('filename')
        build_cmd = java.fetch('build')

        puts "Build #{filename} ..."
        puts %x(#{build_cmd})
        puts ""
      end
    end

    def command_execute(filter = nil)
      javajava = parse_project!
      javajava = filter_javajava(javajava, filter) if filter
      javajava.each do |java|
        filename = java.fetch('filename')
        run_cmd = java.fetch('run')

        puts "Execute #{filename} ..."
        puts %x(#{run_cmd})
        puts ""
      end
    end

    def command_run(filter = nil)
      command_build(filter)
      command_execute(filter)
    end
  end
end
