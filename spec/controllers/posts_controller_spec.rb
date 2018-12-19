require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    before { sign_in create(:user) }

    describe 'GET #index' do
        before { create_list(:post, 5) }

        it 'retorna todos os posts' do
            get :index
            expect(assigns(:posts)).to eq Post.all
        end
    end

    describe 'GET #show' do
        context 'quando registro existe' do
            let!(:post) { create :post }

            it 'retorna o post' do
                get :show, params: { id: post.id }
                expect(assigns(:post)).to eq post
            end

            it 'renderiza show template' do
                get:show, params: { id: post.id }
                expect(response).to render_template :show

            end
        end

        context 'quando o registro não existe' do
            it 'redireciona para root_path' do
                get :show, params: { id: 0 }
                expect(response).to redirect_to(root_path)
            end
        end
    end

    describe 'GET #new' do
        it 'inicializa um novo post' do
            get :new
            expect(assigns(:post)).to be_instance_of Post
        end

        it 'renderiza new template' do
            get :new
            expect(response).to  render_template :new
        end
    end

    describe 'POST #create' do
        context 'os parametros são válidos' do
            let!(:parametros_validos) { attributes_for :post }
            it 'cria um novo post' do
                expect do
                    get :create, params: { post: parametros_validos }
                end.to change(Post, :count).by(1)
            end
            it 'exibe mensagem de sucesso' do
                get :create, params: { post: parametros_validos }
                expect(flash[:notice]).to match(/Post criado com sucesso/)
            end
        end
        context 'os parametros não são válidos' do
            let(:parametros_invalidos) { attributes_for :post, title: '' }

            it 'não cria um novo post' do
                 expect do
                    get :create, params: { post: parametros_invalidos }
                 end.to_not change(Post, :count)
            end

            it 'renderiza new template' do
                get :create, params: { post: parametros_invalidos }
                expect(response).to render_template :new
            end
        end
    end

    # posts/edit/1
    describe 'GET #edit' do
        let!(:post) { create :post }

        it 'retorna o post' do
            get :edit, params: { id: post.id }
            expect(assigns(:post)).to eq post
        end

        it 'renderiza edit template' do
            get :edit, params: { id: post.id }
            expect(response).to render_template :edit
        end
    end

    # patch posts/edit/1
    describe 'PATH #update' do
        let!(:post) { create :post}

        context 'quando os atributos são válidos' do
            let(:parametros_validos) do
                { title: 'New Title' }
            end

            it 'atualiza os atributos' do
                patch :update, params: { id: post.id, post: parametros_validos }
                expect(assigns(:post)['title']).to eq 'New Title'
            end

            it 'redireciona para show' do
                patch :update, params: { id: post.id, post: parametros_validos }
                expect(response).to redirect_to(post_path(post))
            end
        end

        context 'quando os atributos não são validos' do
            let(:parametros_invalidos) do
                { title: '' }
            end

            it 'renderiza template edit' do
                patch :update, params: { id: post.id, post: parametros_invalidos }
                expect(response).to render_template :edit
            end
        end
    end

    describe 'DELETE #destroy' do
        let!(:post) {create :post}

        it 'excluir o post' do
            expect do 
                delete :destroy, params: { id: post.id }
            end.to change(Post, :count).by(-1)
        end

        it 'redireciona para index' do
            delete :destroy, params: { id: post.id }
            expect(response).to redirect_to(posts_path)
        end

        it 'exibe mensagem de exclusão' do
            delete :destroy, params: { id: post.id }
            expect(flash[:notice]).to match(/Post excluido com sucesso/)
        end

    end
end
