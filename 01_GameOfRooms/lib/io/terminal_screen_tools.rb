require 'terminfo'

module TerminalScreenTools

  class Screen

    @@screen_size = TermInfo.screen_size
    @@screen_height = @@screen_size[0]
    @@screen_width = @@screen_size[1]

    def self.print_centered(text)
      text = center_horizontaly(text)
      text = center_verticaly(text)
      puts text
    end

    def self.print_horizontaly_centered(text)
      text = center_horizontaly(text)
      puts text
    end

    def self.clear_screen
      system "clear" or system "cls"
    end

    private

    def self.center_horizontaly(text)
      result_text = ""
      text_lines = text.split(/\n/)
      text_lines.each do |line|
        spaces_left = [(@@screen_width / 2  - line.size / 2), 0].max
        result_text += (" " * spaces_left) + line + "\n"
      end
      return result_text
    end

    def self.center_verticaly(text)
      lines_before = [(@@screen_height / 2 - text.split(/\n/).size / 2), 0].max
      return ("\n" * lines_before) + text + ("\n" * lines_before)
    end

  end

end
