require "rails_helper"

describe ProductArchivatesController do
  describe '#destroy' do
    context 'when user is admin' do
      it 'redirects to root' do
        product = create(:product)
        user = create(:admin)
        allow(controller).to receive(:current_user).and_return(user)

        delete :destroy, params: { product_id: product.id }

        expect(response).to redirect_to(root_path)
      end

      it 'shoult call archivate! method' do
        product = create(:product, archived: false)
        user = create(:admin)
        allow(controller).to receive(:current_user).and_return(user)

        delete :destroy, params: { product_id: product.id }

        product.reload
        expect(product.archived).to eq(true)
      end
    end

    context 'when user is not admin' do
      it 'should be not authorize' do
        product = create(:product, archived: false)
        user = create(%i(employee manager).sample)
        allow(controller).to receive(:current_user).and_return(user)

        delete :destroy, params: { product_id: product.id }

        product.reload
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You are not authorized to perform this action')
        expect(product.archived).to eq(false)
      end
    end

    context 'when user is not authenticated' do
      it 'should redirect to login' do
        product = create(:product, archived: false)

        delete :destroy, params: { product_id: product.id }

        product.reload
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq('Please login first')
        expect(product.archived).to eq(false)
      end
    end
  end
end
