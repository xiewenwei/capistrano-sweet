
namespace :sweet do
  desc 'custom_links'
  task :custom_links do
    on roles(:app) do
      links = fetch(:custom_links) || []
      links.each do |link|
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

#after 'deploy:symlink:shared', 'sweet:custom_links'
