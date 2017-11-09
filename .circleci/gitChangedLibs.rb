require 'json'

$GITPRAPI = "https://api.github.com/repos/forcedotcom/SalesforceMobileSDK-android/pulls/%s/files"
$libs = ["SalesforceAnalytics", "SalesforceHybridSDK", "SalesforceReact", "SalesforceSDKCore", "SmartStore", "SmartSync"]

prFilesAPI = $GITPRAPI % ENV["CIRCLE_PR_NUMBER"]
curlCommand = "curl %s -H 'Authorization: token %s'" % [prFilesAPI, ENV["CIRCLE_TOKEN"]]
pullfiles = `#{curlCommand}`
prfiles = JSON.parse(pullfiles)

# delete me
puts "PR Files: " + prfiles.to_a().join(",")

for prfile in prfiles
  path = prfile["filename"]
  for lib in $libs
    if path.include? lib
      testLibs = testLibs.add(lib)
    end
  end
end
puts "Libs:" + testLibs.to_a().join(",")
