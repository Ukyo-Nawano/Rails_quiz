Rails.application.config.session_store :redis_store, {
    servers: [
      {
        host: "localhost", 
        port: 6379, 
        db: 0, 
        namespace: "session"
      }
    ], 
    key: "_rails_quiz_session", 
    expire_after: 90.minutes
  }