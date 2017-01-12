=begin
Copyright 2016 Shine Solutions
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
=end

Puppet::Type.newtype(:aem_user)do

  ensurable do

    newvalue(:password_changed) do
      provider.change_password
    end

    newvalue(:present) do
      if @resource.provider and @resource.provider.respond_to?(:create)
        @resource.provider.create
      else
        @resource.create
      end
      nil
    end

    newvalue(:absent) do
      if @resource.provider and @resource.provider.respond_to?(:destroy)
        @resource.provider.destroy
      else
        @resource.destroy
      end
      nil
    end

  end

  newparam :name, :namevar => false do
    desc 'User name'
    validate do |value|
      fail 'User name must be provided' if value == ''
    end
  end

  newparam :path do
    desc 'User path'
    validate do |value|
      fail 'User path must be provided' if value == ''
    end
  end

  newparam :password do
    desc 'User password'
  end

  newparam :old_password do
    desc 'Old user password'
  end

  newparam :new_password do
    desc 'New user password'
  end

end