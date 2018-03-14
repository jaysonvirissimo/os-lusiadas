# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#destroy' do
    context 'when signed in' do
      let(:id) { user.id }
      let(:user) { Fabricate(:user) }
      subject { delete :destroy, params: { id: id } }

      before do
        allow_any_instance_of(described_class)
          .to receive(:current_user)
          .and_return(user)
      end

      it 'deletes the given user' do
        expect(User.find_by(id: id)).to be
        expect(subject).to redirect_to(root_url)
        expect(User.find_by(id: id)).to_not be
      end
    end
  end
end
