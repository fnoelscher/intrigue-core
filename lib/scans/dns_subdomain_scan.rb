module Intrigue
module Scanner
class DnsSubdomainScan < Intrigue::Scanner::Base

    private

    ### 
    ### Main "workflow" function
    ###
    def _recurse(entity, depth)

      if depth <= 0      # Check for bottom of recursion
        @scan_result.logger.log "Returning, depth @ #{depth}"
        return
      end

      if entity.type_string == "DnsRecord"
        ### DNS Subdomain Bruteforce
        _start_task_and_recurse "dns_brute_sub",entity,depth,[
          {"name" => "use_file", "value" => true },
          {"name" => "brute_alphanumeric_size", "value" => 1},
          {"name" => "use_permutations", "value" => true }
        ]
      else
        @scan_result.logger.log "SKIP Unhandled entity type: #{entity.type}##{entity.attributes["name"]}"
        return
      end
    end

end
end
end
