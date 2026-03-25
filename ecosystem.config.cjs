module.exports = {
  apps: [
    {
      name: 'hospital-tourism',
      script: './start-server.sh',
      env: {
        NODE_ENV: 'production'
      },
      instances: 1,
      exec_mode: 'fork',
      max_memory_restart: '500M',
      autorestart: true,
      watch: false,
      ignore_watch: ['node_modules', 'dist/.git']
    }
  ]
};
