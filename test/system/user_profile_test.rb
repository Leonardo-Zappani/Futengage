# frozen_string_literal: true

require 'application_system_test_case'

class TransactionsTest < ApplicationSystemTestCase
  setup do
    sign_in users(:user_one)
  end

  test 'visiting profile menu' do
    visit imports_url
    click_on id: 'menu_button_profile'
    click_on 'Perfil do usuário'
  end

  test 'editing name' do
    visit imports_url
    click_on id: 'menu_button_profile'
    click_on 'Perfil do usuário'
    fill_in id: 'user_first_name', with: 'Lorem ipsum'
    fill_in id: 'user_last_name', with: 'Lorem ipsum'
    fill_in id: 'user_email', with: 'loremipsum@gmail.com'
    click_on 'Atualizar perfil'
  end

  test 'editing password' do
    visit imports_url
    click_on id: 'menu_button_profile'
    click_on 'Perfil do usuário'
    fill_in id: 'user_password', with: 'Lorem ipsum'
    fill_in id: 'user_password_confirmation', with: 'Lorem ipsum'
    click_on 'Atualizar perfil'
  end

  test 'changing profile picture company' do
    visit imports_url
    click_on id: 'menu_button_profile'
    click_on 'Perfil do usuário'
    attach_file "user_avatar", file_fixture("profile.jpg")
    sleep 0.2
    click_on 'Atualizar perfil'
  end

  test 'logout' do
    visit imports_url
    click_on id: 'menu_button_profile'
    click_on 'Perfil do usuário'
    click_on 'Sair'
  end

  test 'about' do
    visit imports_url
    click_on 'Sobre'
  end

  test 'privacy' do
    visit imports_url
    click_on 'Privacidade'
  end

  test 'terms' do
    visit imports_url
    click_on 'Termos de uso'
  end
end