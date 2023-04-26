Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09926EF518
	for <lists+linux-s390@lfdr.de>; Wed, 26 Apr 2023 15:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbjDZNIK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 26 Apr 2023 09:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241032AbjDZNII (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Apr 2023 09:08:08 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27487449D;
        Wed, 26 Apr 2023 06:08:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vh3QWc2_1682514478;
Received: from 30.221.144.140(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Vh3QWc2_1682514478)
          by smtp.aliyun-inc.com;
          Wed, 26 Apr 2023 21:08:00 +0800
Message-ID: <4253f27c-2c5e-3033-14b3-6e31ee344e8b@linux.alibaba.com>
Date:   Wed, 26 Apr 2023 21:07:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v3 51/55] smc: Drop smc_sendpage() in favour of
 smc_sendmsg() + MSG_SPLICE_PAGES
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20230331160914.1608208-1-dhowells@redhat.com>
 <20230331160914.1608208-52-dhowells@redhat.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20230331160914.1608208-52-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


Hi David,

Fallback is one of the most important features of SMC, which 
automatically downgrades to TCP
when SMC discovers that the peer does not support SMC. After fallback, 
SMC hopes the the ability can be
consistent with that of TCP sock. If you delete the smc_sendpage, when 
fallback occurs, it means that the sock after the fallback
loses the ability of  sendpage( tcp_sendpage).

Thanks
D. Wythe

On 4/1/23 12:09 AM, David Howells wrote:
> Drop the smc_sendpage() code as smc_sendmsg() just passes the call down to
> the underlying TCP socket and smc_tx_sendpage() is just a wrapper around
> its sendmsg implementation.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Karsten Graul <kgraul@linux.ibm.com>
> cc: Wenjia Zhang <wenjia@linux.ibm.com>
> cc: Jan Karcher <jaka@linux.ibm.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-s390@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
>   net/smc/af_smc.c    | 29 -----------------------------
>   net/smc/smc_stats.c |  2 +-
>   net/smc/smc_stats.h |  1 -
>   net/smc/smc_tx.c    | 16 ----------------
>   net/smc/smc_tx.h    |  2 --
>   5 files changed, 1 insertion(+), 49 deletions(-)
>
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index a4cccdfdc00a..d4113c8a7cda 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -3125,34 +3125,6 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
>   	return put_user(answ, (int __user *)arg);
>   }
>   
> -static ssize_t smc_sendpage(struct socket *sock, struct page *page,
> -			    int offset, size_t size, int flags)
> -{
> -	struct sock *sk = sock->sk;
> -	struct smc_sock *smc;
> -	int rc = -EPIPE;
> -
> -	smc = smc_sk(sk);
> -	lock_sock(sk);
> -	if (sk->sk_state != SMC_ACTIVE) {
> -		release_sock(sk);
> -		goto out;
> -	}
> -	release_sock(sk);
> -	if (smc->use_fallback) {
> -		rc = kernel_sendpage(smc->clcsock, page, offset,
> -				     size, flags);
> -	} else {
> -		lock_sock(sk);
> -		rc = smc_tx_sendpage(smc, page, offset, size, flags);
> -		release_sock(sk);
> -		SMC_STAT_INC(smc, sendpage_cnt);
> -	}
> -
> -out:
> -	return rc;
> -}
> -
>   /* Map the affected portions of the rmbe into an spd, note the number of bytes
>    * to splice in conn->splice_pending, and press 'go'. Delays consumer cursor
>    * updates till whenever a respective page has been fully processed.
> @@ -3224,7 +3196,6 @@ static const struct proto_ops smc_sock_ops = {
>   	.sendmsg	= smc_sendmsg,
>   	.recvmsg	= smc_recvmsg,
>   	.mmap		= sock_no_mmap,
> -	.sendpage	= smc_sendpage,
>   	.splice_read	= smc_splice_read,
>   };
>   
> diff --git a/net/smc/smc_stats.c b/net/smc/smc_stats.c
> index e80e34f7ac15..ca14c0f3a07d 100644
> --- a/net/smc/smc_stats.c
> +++ b/net/smc/smc_stats.c
> @@ -227,7 +227,7 @@ static int smc_nl_fill_stats_tech_data(struct sk_buff *skb,
>   			      SMC_NLA_STATS_PAD))
>   		goto errattr;
>   	if (nla_put_u64_64bit(skb, SMC_NLA_STATS_T_SENDPAGE_CNT,
> -			      smc_tech->sendpage_cnt,
> +			      0,
>   			      SMC_NLA_STATS_PAD))
>   		goto errattr;
>   	if (nla_put_u64_64bit(skb, SMC_NLA_STATS_T_CORK_CNT,
> diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
> index 84b7ecd8c05c..b60fe1eb37ab 100644
> --- a/net/smc/smc_stats.h
> +++ b/net/smc/smc_stats.h
> @@ -71,7 +71,6 @@ struct smc_stats_tech {
>   	u64			clnt_v2_succ_cnt;
>   	u64			srv_v1_succ_cnt;
>   	u64			srv_v2_succ_cnt;
> -	u64			sendpage_cnt;
>   	u64			urg_data_cnt;
>   	u64			splice_cnt;
>   	u64			cork_cnt;
> diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
> index f4b6a71ac488..d31ce8209fa2 100644
> --- a/net/smc/smc_tx.c
> +++ b/net/smc/smc_tx.c
> @@ -298,22 +298,6 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
>   	return rc;
>   }
>   
> -int smc_tx_sendpage(struct smc_sock *smc, struct page *page, int offset,
> -		    size_t size, int flags)
> -{
> -	struct msghdr msg = {.msg_flags = flags};
> -	char *kaddr = kmap(page);
> -	struct kvec iov;
> -	int rc;
> -
> -	iov.iov_base = kaddr + offset;
> -	iov.iov_len = size;
> -	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, size);
> -	rc = smc_tx_sendmsg(smc, &msg, size);
> -	kunmap(page);
> -	return rc;
> -}
> -
>   /***************************** sndbuf consumer *******************************/
>   
>   /* sndbuf consumer: actual data transfer of one target chunk with ISM write */
> diff --git a/net/smc/smc_tx.h b/net/smc/smc_tx.h
> index 34b578498b1f..a59f370b8b43 100644
> --- a/net/smc/smc_tx.h
> +++ b/net/smc/smc_tx.h
> @@ -31,8 +31,6 @@ void smc_tx_pending(struct smc_connection *conn);
>   void smc_tx_work(struct work_struct *work);
>   void smc_tx_init(struct smc_sock *smc);
>   int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len);
> -int smc_tx_sendpage(struct smc_sock *smc, struct page *page, int offset,
> -		    size_t size, int flags);
>   int smc_tx_sndbuf_nonempty(struct smc_connection *conn);
>   void smc_tx_sndbuf_nonfull(struct smc_sock *smc);
>   void smc_tx_consumer_update(struct smc_connection *conn, bool force);

