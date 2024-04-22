---
- name: deploy lamp stack
  hosts: all
  become: true
  tasks:
    - name: Copy file with owner and permissions
      ansible.builtin.copy:
        src: /home/vagrant/myscript.sh
        dest: /home/vagrant/myscript.sh
        owner: root
        group: root
        mode: '0755'

    - name: install lamp stack and laravel
      script: /home/vagrant/myscript.sh

    - name: Copy uptime check script to server
      copy:
        src: /home/vagrant/myserveruptime.sh
        dest: /usr/local/bin/myserveruptime.sh
        mode: "0755"

    - name: Schedule uptime check cron job
      cron:
      name: Check server uptime
      minute: "0"
      hour: "0"
      job: /usr/local/bin/myserveruptime.sh
      cron_file: uptime_check
      user: TrippyStorm
      
