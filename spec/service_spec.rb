#!/usr/bin/env ruby
require 'spec_helper'

shared_examples 'service' do |service: |
  shared_context 'when enabled' do
    before do
      fail unless run(command_enable, service).success?
    end
  end

  shared_context 'when disabled' do
    before do
      fail unless run(command_disable, service).success?
    end
  end

  describe 'is_enabled' do
    let(:command_enable) { :enable_service }
    let(:command_disable) { :disable_service }
    let(:command_is_enabled) { :check_service_is_enabled }

    subject { run(command_is_enabled, service) }

    context 'when disabled' do
      include_context 'when disabled'

      it { is_expected.to be_failure }
    end

    context 'when enabled' do
      include_context 'when enabled'

      it { is_expected.to be_success }
    end
  end

  describe 'is_enabled_under_systemd' do
    let(:command_enable) { :enable_service_under_systemd }
    let(:command_disable) { :disable_service_under_systemd }
    let(:command_is_enabled) { :check_service_is_enabled_under_systemd }

    subject { run(command_is_enabled, service) }

    context 'when disabled' do
      include_context 'when disabled'

      it { is_expected.to be_failure }
    end

    context 'when enabled' do
      include_context 'when enabled'

      it { is_expected.to be_success }
    end
  end
end

describe 'specinfra' do
  def run(cmd, *args)
    $backend.run_command($backend.command.get(cmd, *args))
  end

  it_behaves_like 'service', service: 'cron'
  it_behaves_like 'service', service: 'exim4'
  it_behaves_like 'service', service: 'ntp'
end
