module.exports = {
    listen: {
        host: '127.0.0.1',
        port: 8000,
    },
    connectionString: {
        user:     'servicesweb',  // env var: PGUSER
        database: 'ircservices',  // env var: PGDATABASE
        password: '<%= @servicesweb_pass %>', // env var: PGPASSWORD
        host:     '<%= @pghost %>', // env var: PGHOST
        port:     <%= @pgport %>,           // env var: PGPORT
        ssl:      true,
        max:      10,             // max number of clients in the pool
        idleTimeoutMillis: 30000, // how long a client is allowed to remain idle before being closed
    },
    tokenSecret: '<%= @servicesweb_tokensecret %>',
    recaptcha_sitekey: '<%= @servicesweb_recaptcha_sitekey %>',
    recaptcha_secretkey: '<%= @servicesweb_recaptcha_secretkey %>',
}
