
namespace :sweet do
  desc 'synch vendor cache'
  task :synch_vendor_cache do
    on roles(:app) do
      source = "vendor/cache"
      target = "#{shared_path}/gem-cache/vendor/cache"

      # step 1 make sure gem-cache/vendor is exists in shared_path
      execute(:mkdir, '-p', target)

      # step 2 link vendor/cache to gem-cache/vendor/cache
      execute :ln, '-nsf', target, "#{release_path}/vendor/cache"

      # step 3 fetch gem file list from remote server
      remote_gems_result = capture("ls #{target}/")

      remote_gems = remote_gems_result.split("\n").map do |i|
        File.basename(i)
      end

      #puts "remote_gems is #{remote_gems.inspect}"

      # step 4 find no exists gems

      local_gems = Dir["#{source}/*.gem"].map { |i| File.basename(i) }

      #puts "local_gems is #{local_gems.inspect}"

      # step 5 upload no exists gems
      added_gems = local_gems - remote_gems

      puts "Missing gems #{added_gems}"

      added_gems.each do |i|
        upload! "#{source}/#{i}", "#{target}/#{i}"
      end
    end
  end
end

before 'bundler:install', 'sweet:synch_vendor_cache'
