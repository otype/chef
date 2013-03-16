def defaults_options
  options = node['cookbooks.haproxy']['defaults_options']
  if node['cookbooks.haproxy']['x_forwarded_for']
    options.push("forwardfor")
  end
  return options.uniq
end

def defaults_timeouts
  node['cookbooks.haproxy']['defaults_timeouts']
end
