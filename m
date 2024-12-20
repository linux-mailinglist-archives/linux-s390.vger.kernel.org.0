Return-Path: <linux-s390+bounces-7821-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 664729F8BB3
	for <lists+linux-s390@lfdr.de>; Fri, 20 Dec 2024 06:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0F316AF22
	for <lists+linux-s390@lfdr.de>; Fri, 20 Dec 2024 05:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C1778F59;
	Fri, 20 Dec 2024 05:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qvL8nduV"
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D9010F1;
	Fri, 20 Dec 2024 05:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734671057; cv=none; b=SqbfmXYQYRGXs50cLk8nw4rMfPUCjlTO+guMMVGCGs8/wiwGOkmpYdbR9Oi2dHFp2k22wEA+2hojCaAS5pBOENmksYIeGDL143gTzW7jXPrvcTHiXqgbCcEZE3FiMXnXEuoUjaEKxf6RFiEKvmCrtaOowJqE9CiKv8Y4pMrdqlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734671057; c=relaxed/simple;
	bh=s+S7ns2RPkG8QpLLMnY9GqT8IJt2rSN14Z53IpO0+Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWLRXlGAGxlBWlgYJXHvlnMejKAMSDfIo0i9xTjt4A+HJ3Qb25n3wKU0PrUsvUIaHCkNx4tL+yrstgIHlTQmGGBOagr24UXmwzyegG7wpozD6Cx7gjf2bcUzBHXAD4AbEODLnqQODgIFDteBTREJdjCv2SSPf5UJm3gf3oPzo3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qvL8nduV; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734671050; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ta2UnE0H9gJx+Oy6F9rbkHavzEAR55xBIvVkDAvqZc0=;
	b=qvL8nduVK5u27ZZVrqS1yS8qc08cukE/lpa/z7IcwSH6JaJj6oYpTAtGwtmrIz9UEznE0SO0e9ViNUMqBe95SnKYGghNTw+JF3a79NMzGBjvlBNP1P87WpRJMFQgUqX9S1GMXIQOZoW+64GXudKhAIGnFaPolwF98lWUjhB9YP0=
Received: from 30.221.101.41(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WLsYLoO_1734671047 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Dec 2024 13:04:10 +0800
Message-ID: <0c2710b6-1d5f-465d-99bf-1a0e3c974a32@linux.alibaba.com>
Date: Fri, 20 Dec 2024 13:04:06 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix data error when recvmsg with MSG_PEEK
 flag
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, PASIC@de.ibm.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241220031451.52343-1-guangguan.wang@linux.alibaba.com>
 <20241220033922.GA33005@j66a10360.sqa.eu95>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20241220033922.GA33005@j66a10360.sqa.eu95>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/12/20 11:39, D. Wythe wrote:
> On Fri, Dec 20, 2024 at 11:14:51AM +0800, Guangguan Wang wrote:
>> When recvmsg with MSG_PEEK flag, the data will be copied to
>> user's buffer without advancing consume cursor and without
>> reducing the length of rx available data. Once the expected
>> peek length is larger than the value of bytes_to_rcv, in the
>> loop of do while in smc_rx_recvmsg, the first loop will copy
>> bytes_to_rcv bytes of data from the position local_tx_ctrl.cons,
>> the second loop will copy the min(bytes_to_rcv, read_remaining)
>> bytes from the position local_tx_ctrl.cons again because of the
>> lacking of process with advancing consume cursor and reducing
>> the length of available data. So do the subsequent loops. The
>> data copied in the second loop and the subsequent loops will
>> result in data error, as it should not be copied if no more data
>> arrives and it should be copied from the position advancing
>> bytes_to_rcv bytes from the local_tx_ctrl.cons if more data arrives.
>>
> 
> 
> What would happen if I did this:
> 
> recv(conn->rmb_desc->len + 1 , MSG_PEEK | MSG_WAITALL)
> 
> endless waiting?
> 

Yes, it will endless waiting. But I think the behaviour is expected currently as
the expected bytes to peek is not reached.

I do not know the behaviour of TCP if the expected bytes to peek exceeds the max length
of recv buffer. It maybe be an another issue or optimization if the behaviour is different
between TCP and SMC.

Thanks,
Guangguan Wang

> 
>> This issue can be reproduce by the following python script:
>> server.py:
>> import socket
>> import time
>> server_ip = '0.0.0.0'
>> server_port = 12346
>> server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
>> server_socket.bind((server_ip, server_port))
>> server_socket.listen(1)
>> print('Server is running and listening for connections...')
>> conn, addr = server_socket.accept()
>> print('Connected by', addr)
>> while True:
>>     data = conn.recv(1024)
>>     if not data:
>>         break
>>     print('Received request:', data.decode())
>>     conn.sendall(b'Hello, client!\n')
>>     time.sleep(5)
>>     conn.sendall(b'Hello, again!\n')
>> conn.close()
>>
>> client.py:
>> import socket
>> server_ip = '<server ip>'
>> server_port = 12346
>> resp=b'Hello, client!\nHello, again!\n'
>> client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
>> client_socket.connect((server_ip, server_port))
>> request = 'Hello, server!'
>> client_socket.sendall(request.encode())
>> peek_data = client_socket.recv(len(resp),
>>     socket.MSG_PEEK | socket.MSG_WAITALL)
>> print('Peeked data:', peek_data.decode())
>> client_socket.close()
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> ---
>>  net/smc/af_smc.c |  2 +-
>>  net/smc/smc_rx.c | 37 +++++++++++++++++++++----------------
>>  net/smc/smc_rx.h |  8 ++++----
>>  3 files changed, 26 insertions(+), 21 deletions(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 6cc7b846cff1..ebc41a7b13db 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -2738,7 +2738,7 @@ int smc_accept(struct socket *sock, struct socket *new_sock,
>>  			release_sock(clcsk);
>>  		} else if (!atomic_read(&smc_sk(nsk)->conn.bytes_to_rcv)) {
>>  			lock_sock(nsk);
>> -			smc_rx_wait(smc_sk(nsk), &timeo, smc_rx_data_available);
>> +			smc_rx_wait(smc_sk(nsk), &timeo, 0, smc_rx_data_available);
>>  			release_sock(nsk);
>>  		}
>>  	}
>> diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
>> index f0cbe77a80b4..79047721df51 100644
>> --- a/net/smc/smc_rx.c
>> +++ b/net/smc/smc_rx.c
>> @@ -238,22 +238,23 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
>>  	return -ENOMEM;
>>  }
>>  
>> -static int smc_rx_data_available_and_no_splice_pend(struct smc_connection *conn)
>> +static int smc_rx_data_available_and_no_splice_pend(struct smc_connection *conn, size_t peeked)
>>  {
>> -	return atomic_read(&conn->bytes_to_rcv) &&
>> +	return smc_rx_data_available(conn, peeked) &&
>>  	       !atomic_read(&conn->splice_pending);
>>  }
>>  
>>  /* blocks rcvbuf consumer until >=len bytes available or timeout or interrupted
>>   *   @smc    smc socket
>>   *   @timeo  pointer to max seconds to wait, pointer to value 0 for no timeout
>> + *   @peeked  number of bytes already peeked
>>   *   @fcrit  add'l criterion to evaluate as function pointer
>>   * Returns:
>>   * 1 if at least 1 byte available in rcvbuf or if socket error/shutdown.
>>   * 0 otherwise (nothing in rcvbuf nor timeout, e.g. interrupted).
>>   */
>> -int smc_rx_wait(struct smc_sock *smc, long *timeo,
>> -		int (*fcrit)(struct smc_connection *conn))
>> +int smc_rx_wait(struct smc_sock *smc, long *timeo, size_t peeked,
>> +		int (*fcrit)(struct smc_connection *conn, size_t baseline))
>>  {
>>  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>>  	struct smc_connection *conn = &smc->conn;
>> @@ -262,7 +263,7 @@ int smc_rx_wait(struct smc_sock *smc, long *timeo,
>>  	struct sock *sk = &smc->sk;
>>  	int rc;
>>  
>> -	if (fcrit(conn))
>> +	if (fcrit(conn, peeked))
>>  		return 1;
>>  	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>>  	add_wait_queue(sk_sleep(sk), &wait);
>> @@ -271,7 +272,7 @@ int smc_rx_wait(struct smc_sock *smc, long *timeo,
>>  			   cflags->peer_conn_abort ||
>>  			   READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN ||
>>  			   conn->killed ||
>> -			   fcrit(conn),
>> +			   fcrit(conn, peeked),
>>  			   &wait);
>>  	remove_wait_queue(sk_sleep(sk), &wait);
>>  	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>> @@ -322,11 +323,11 @@ static int smc_rx_recv_urg(struct smc_sock *smc, struct msghdr *msg, int len,
>>  	return -EAGAIN;
>>  }
>>  
>> -static bool smc_rx_recvmsg_data_available(struct smc_sock *smc)
>> +static bool smc_rx_recvmsg_data_available(struct smc_sock *smc, size_t peeked)
>>  {
>>  	struct smc_connection *conn = &smc->conn;
>>  
>> -	if (smc_rx_data_available(conn))
>> +	if (smc_rx_data_available(conn, peeked))
>>  		return true;
>>  	else if (conn->urg_state == SMC_URG_VALID)
>>  		/* we received a single urgent Byte - skip */
>> @@ -344,10 +345,10 @@ static bool smc_rx_recvmsg_data_available(struct smc_sock *smc)
>>  int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
>>  		   struct pipe_inode_info *pipe, size_t len, int flags)
>>  {
>> -	size_t copylen, read_done = 0, read_remaining = len;
>> +	size_t copylen, read_done = 0, read_remaining = len, peeked_bytes = 0;
>>  	size_t chunk_len, chunk_off, chunk_len_sum;
>>  	struct smc_connection *conn = &smc->conn;
>> -	int (*func)(struct smc_connection *conn);
>> +	int (*func)(struct smc_connection *conn, size_t baseline);
>>  	union smc_host_cursor cons;
>>  	int readable, chunk;
>>  	char *rcvbuf_base;
>> @@ -384,14 +385,14 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
>>  		if (conn->killed)
>>  			break;
>>  
>> -		if (smc_rx_recvmsg_data_available(smc))
>> +		if (smc_rx_recvmsg_data_available(smc, peeked_bytes))
>>  			goto copy;
>>  
>>  		if (sk->sk_shutdown & RCV_SHUTDOWN) {
>>  			/* smc_cdc_msg_recv_action() could have run after
>>  			 * above smc_rx_recvmsg_data_available()
>>  			 */
>> -			if (smc_rx_recvmsg_data_available(smc))
>> +			if (smc_rx_recvmsg_data_available(smc, peeked_bytes))
>>  				goto copy;
>>  			break;
>>  		}
>> @@ -425,26 +426,28 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
>>  			}
>>  		}
>>  
>> -		if (!smc_rx_data_available(conn)) {
>> -			smc_rx_wait(smc, &timeo, smc_rx_data_available);
>> +		if (!smc_rx_data_available(conn, peeked_bytes)) {
>> +			smc_rx_wait(smc, &timeo, peeked_bytes, smc_rx_data_available);
>>  			continue;
>>  		}
>>  
>>  copy:
>>  		/* initialize variables for 1st iteration of subsequent loop */
>>  		/* could be just 1 byte, even after waiting on data above */
>> -		readable = atomic_read(&conn->bytes_to_rcv);
>> +		readable = smc_rx_data_available(conn, peeked_bytes);
>>  		splbytes = atomic_read(&conn->splice_pending);
>>  		if (!readable || (msg && splbytes)) {
>>  			if (splbytes)
>>  				func = smc_rx_data_available_and_no_splice_pend;
>>  			else
>>  				func = smc_rx_data_available;
>> -			smc_rx_wait(smc, &timeo, func);
>> +			smc_rx_wait(smc, &timeo, peeked_bytes, func);
>>  			continue;
>>  		}
>>  
>>  		smc_curs_copy(&cons, &conn->local_tx_ctrl.cons, conn);
>> +		if ((flags & MSG_PEEK) && peeked_bytes)
>> +			smc_curs_add(conn->rmb_desc->len, &cons, peeked_bytes);
>>  		/* subsequent splice() calls pick up where previous left */
>>  		if (splbytes)
>>  			smc_curs_add(conn->rmb_desc->len, &cons, splbytes);
>> @@ -480,6 +483,8 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
>>  			}
>>  			read_remaining -= chunk_len;
>>  			read_done += chunk_len;
>> +			if (flags & MSG_PEEK)
>> +				peeked_bytes += chunk_len;
>>  
>>  			if (chunk_len_sum == copylen)
>>  				break; /* either on 1st or 2nd iteration */
>> diff --git a/net/smc/smc_rx.h b/net/smc/smc_rx.h
>> index db823c97d824..994f5e42d1ba 100644
>> --- a/net/smc/smc_rx.h
>> +++ b/net/smc/smc_rx.h
>> @@ -21,11 +21,11 @@ void smc_rx_init(struct smc_sock *smc);
>>  
>>  int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
>>  		   struct pipe_inode_info *pipe, size_t len, int flags);
>> -int smc_rx_wait(struct smc_sock *smc, long *timeo,
>> -		int (*fcrit)(struct smc_connection *conn));
>> -static inline int smc_rx_data_available(struct smc_connection *conn)
>> +int smc_rx_wait(struct smc_sock *smc, long *timeo, size_t peeked,
>> +		int (*fcrit)(struct smc_connection *conn, size_t baseline));
>> +static inline int smc_rx_data_available(struct smc_connection *conn, size_t peeked)
>>  {
>> -	return atomic_read(&conn->bytes_to_rcv);
>> +	return atomic_read(&conn->bytes_to_rcv) - peeked;
>>  }
>>  
>>  #endif /* SMC_RX_H */
>> -- 
>> 2.24.3 (Apple Git-128)
>>

