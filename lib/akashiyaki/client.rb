# frozen_string_literal: true

require "mechanize"

module Akashiyaki
  class Client
    DEFAULT_REQUEST_HEADERS = {
      "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
    }.freeze

    LOGIN_URL = "https://atnd.ak4.jp/login"
    LOGIN_FORM_ID = "new_form"
    LOGIN_FORM_FIELDS = {
      company_id: "form[company_id]",
      login_id: "form[login_id]",
      password: "form[password]",
    }.freeze

    DAKOKU_FORM_ID = "new_form"
    DAKOKU_FORM_FIELDS = {
      authenticity_token: "authenticity_token",
      local_time: "form[local_time]",
      type: "form[type]",
    }.freeze
    DAKOKU_REQUEST_HEADERS = {
      "X-Requested-With" => "XMLHttpRequest",
      "Accept" => "*/*;q=0.5, text/javascript, application/javascript, application/ecmascript, application/x-ecmascript",
    }.freeze
    DAKOKU_TYPES = {
      start_work: "attendance",
      finish_work: "leaving",
      start_break: "break_begin",
      finish_break: "break_end",
    }.freeze

    def initialize(company_id, login_id, password)
      @account = {
        company_id: company_id,
        login_id: login_id,
        password: password,
      }.freeze
    end

    def login
      @account.each do |field, value|
        login_form[LOGIN_FORM_FIELDS[field]] = value
      end
      login_form.submit
    end

    def start_work
      dakoku(DAKOKU_TYPES[:start_work])
    end

    def finish_work
      dakoku(DAKOKU_TYPES[:finish_work])
    end

    def start_break
      dakoku(DAKOKU_TYPES[:start_break])
    end

    def finish_break
      dakoku(DAKOKU_TYPES[:finish_break])
    end

    private

    def agent
      @agent ||= Mechanize.new.tap do |a|
        a.user_agent_alias = "Mac Mozilla"
        a.request_headers = DEFAULT_REQUEST_HEADERS
      end
    end

    def authenticity_token
      dakoku_form[DAKOKU_FORM_FIELDS[:authenticity_token]]
    end

    def dakoku(type)
      dakoku_form[DAKOKU_FORM_FIELDS[:local_time]] = Time.now.iso8601
      dakoku_form[DAKOKU_FORM_FIELDS[:type]] = type
      dakoku_form.submit(nil, dakoku_headers)
    end

    def dakoku_headers
      DAKOKU_REQUEST_HEADERS.merge(
        "X-CSRF-Token" => authenticity_token
      )
    end

    def dakoku_form
      @dakoku_form ||= dakoku_page.form_with(id: DAKOKU_FORM_ID)
    end

    def dakoku_page
      @dakoku_page ||= login
    end

    def login_form
      @login_form ||= login_page.form_with(id: LOGIN_FORM_ID)
    end

    def login_page
      @login_page ||= agent.get(LOGIN_URL)
    end
  end
end
