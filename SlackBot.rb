# coding: utf-8
require 'json'
require 'uri'
require 'yaml'
require 'net/https'

class SlackBot
  def initialize(settings_file_path = "settings.yml")
    @config = YAML.load_file(settings_file_path) if File.exist?(settings_file_path)

    # This code assumes to set api keys as evironment variable in Heroku
    # SlackBot uses settings.yml as config when it serves on local
    @google_maps_api = ENV['GOOGLE_MAPS_API_KEY'] || @config["google_maps_api_key"]
    @git_username = ENV['GIT_USERNAME'] || @config["git_username"]
    @git_password = ENV['GIT_PASSWORD'] || @config["git_password"]
    @google_places_api_key = ENV['GOOGLE_PLACES_API_KEY'] || @config["google_places_api_key"]
    @yahoo_api = ENV['YAHOO_API_KEY'] || @config["yahoo_api_key"]
    @slack_incoming_webhook = ENV['slack_incoming_webhook'] || @config["slack_incoming_webhook"]
  end
  def naive_respond(params, options = {})
    return nil if params[:user_name] == "slackbot" || params[:user_id] == "USLACKBOT"

    user_name = params[:user_name] ? "@#{params[:user_name]}" : ""
    return {text: "#{user_name} Hi!"}.merge(options).to_json
  end
end
