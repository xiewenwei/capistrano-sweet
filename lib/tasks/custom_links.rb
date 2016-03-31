
namespace :sweet do
  desc 'custom_links'
  task :custom_links do
    on roles(:app) do
      fetch(:custom_links).each do |link|
        source = link[:source]
        target = link[:target]
        unless test "[ -L #{target} ]"
          execute :rmdir, target if test "[ -d #{target} ]"
          execute :ln, '-nsf', source, target
        end
      end
    end
  end
end

after 'deploy:symlink:shared', 'sweet:custom_links'
