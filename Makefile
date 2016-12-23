ci: tools deps clean lint

deps:
	gem install bundler
	rm -rf .bundle
	bundle install

clean:
	rm -rf test/integration/modules/

lint:
	puppet-lint \
		--fail-on-warnings \
		--no-140chars-check \
		--no-autoloader_layout-check \
		--no-documentation-check \
		--no-only_variable_string-check \
		--no-selector_inside_resource-check \
		test/integration/*.pp

test-integration:
	mkdir -p test/integration/modules/aem/
	cp -R lib test/integration/modules/aem/
	puppet apply --modulepath=test/integration/modules/ test/integration/aem_bundle_stopped.pp
	puppet apply --modulepath=test/integration/modules/ test/integration/aem_bundle_started.pp
	puppet apply --modulepath=test/integration/modules/ test/integration/aem_flush_agent_present.pp
	puppet apply --modulepath=test/integration/modules/ test/integration/aem_flush_agent_absent.pp
	puppet apply --modulepath=test/integration/modules/ test/integration/aem_group_present.pp
	puppet apply --modulepath=test/integration/modules/ test/integration/aem_group_absent.pp
	puppet apply --modulepath=test/integration/modules/ test/integration/aem_package_present.pp
	puppet apply --modulepath=test/integration/modules/ test/integration/aem_package_absent.pp
	puppet apply --modulepath=test/integration/modules/ test/integration/aem_replication_agent_present.pp
	puppet apply --modulepath=test/integration/modules/ test/integration/aem_replication_agent_absent.pp
	puppet apply --modulepath=test/integration/modules/ test/integration/aem_repository.pp

tools:
	gem install puppet puppet-lint

.PHONY: ci clean deps lint test-integration tools
