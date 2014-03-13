# -*- encoding : utf-8 -*-

require 'spec_helper'
require 'guacamole/identity_map'

describe Guacamole::IdentityMap do
  subject { Guacamole::IdentityMap }

  describe 'Management' do
    it 'should always return an identity_map_instance' do
      expect(subject.identity_map_instance).not_to be_nil
    end

    it 'should reset the current map' do
      expect(Hamster).to receive(:hash)

      subject.reset
      subject.identity_map_instance
    end

    it 'should provide a method to construct a key for a given object' do
      some_object = double('SomeObject', key: '1337')

      expect(subject.key_for(some_object)).to eq [some_object.class, some_object.key]
    end
  end

  describe 'Store objects' do
    let(:cupcake) { double('Cupcake', key: '42') }

    before do
      subject.reset
    end

    it 'should use the `key_for` method to construct the map key' do
      expect(subject).to receive(:key_for).with(cupcake).and_return(:the_key)

      subject.store cupcake
    end

    it 'should store the object in the map' do
      subject.store cupcake

      expect(subject.include?(cupcake)).to be_true
    end

    it 'should use an immutable storage' do
      old_map = subject.identity_map_instance
      subject.store cupcake

      expect(old_map.key?(subject.key_for(cupcake))).to be_false
    end
  end

  describe 'Retrieve objects' do
    let(:pony) { double('Pony', key: '23') }

    before do
      subject.store pony
    end

    it 'should load objects from the map' do
      expect(subject.retrieve(pony)).to eq pony
    end

    it 'should load the object based on the key_for result' do
      expect(subject).to receive(:key_for).with(pony)

      subject.retrieve pony
    end
  end
end
