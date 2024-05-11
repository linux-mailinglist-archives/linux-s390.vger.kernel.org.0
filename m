Return-Path: <linux-s390+bounces-3949-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6268C2F20
	for <lists+linux-s390@lfdr.de>; Sat, 11 May 2024 04:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF63C1F22220
	for <lists+linux-s390@lfdr.de>; Sat, 11 May 2024 02:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C482E21106;
	Sat, 11 May 2024 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kf5FqYTR"
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2AB79FD;
	Sat, 11 May 2024 02:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715395581; cv=none; b=PzjZCyaQArBE0nBJ/2w/oPa4/ftraDyzuV55l/gDhrtcgplWiUqzatXUGLKN6abL4d39C4v9bcCSEP8aCGoL/mrZsfDs0WoiRMJ1W58tb/vwQexAXgnT4lVHuxaN6baTbQt5n2xWf41PaXEFvSlHXcbDt3cHQ9iuBri3SKw6Bns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715395581; c=relaxed/simple;
	bh=LF6Vj2p/mXEaxujYc/eimjno5nWgfTE3s+OwGDWY0tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9NZEj3U/aZvNk/7+iyh+b8f6K6wskU5jSBiGxPSQQs6CWqyjUOqZj2MsJYIGDYLneZNeI7MIwMPfqm9ou3+TepesV//1Lq+2ypKFj6qTo6Z2uLJCh73NX81mcm8peKQm+xJGCzbt4G0bw6MdE/bmCGhZcM3+xNQzo7AO49lMqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kf5FqYTR; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715395575; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=54qgT9bfvGJK+Yxjb8Mm2njOtoJY9Z926YyCCZVGLCY=;
	b=kf5FqYTRF9fKKfOlqKZ0TGWC/EuDrHh+WNuTwqxQO0KUoiKsqAdJWNNJ6nXEw0A58GmhsPAiCdt4wSTYh03NEH1uUm7Iz+ELflnZI7xNf0kTEOloPYBx1upy/nJDNhY9AZIMz5ZD3QPH0vd1c6rtAmmgtzyCkgqWaaq3Yv36PYE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6Bw9be_1715395573;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0W6Bw9be_1715395573)
          by smtp.aliyun-inc.com;
          Sat, 11 May 2024 10:46:14 +0800
Date: Sat, 11 May 2024 10:46:13 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next 2/2] net/smc: Introduce IPPROTO_SMC
Message-ID: <20240511024613.GC78725@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <1715314333-107290-1-git-send-email-alibuda@linux.alibaba.com>
 <1715314333-107290-3-git-send-email-alibuda@linux.alibaba.com>
 <20240510095711.GB78725@linux.alibaba.com>
 <76710317-8e9d-4efa-b3e9-1e361ee30135@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76710317-8e9d-4efa-b3e9-1e361ee30135@linux.alibaba.com>

On 2024-05-11 10:23:31, D. Wythe wrote:
>
>
>On 5/10/24 5:57 PM, Dust Li wrote:
>> On 2024-05-10 12:12:13, D. Wythe wrote:
>> > From: "D. Wythe" <alibuda@linux.alibaba.com>
>> > 
>> > This patch allows to create smc socket via AF_INET,
>> > similar to the following code,
>> > 
>> > /* create v4 smc sock */
>> > v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>> > 
>> > /* create v6 smc sock */
>> > v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
>> > 
>> > There are several reasons why we believe it is appropriate here:
>> > 
>> > 1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
>> > address. There is no AF_SMC address at all.
>> > 
>> > 2. Create smc socket in the AF_INET(6) path, which allows us to reuse
>> > the infrastructure of AF_INET(6) path, such as common ebpf hooks.
>> > Otherwise, smc have to implement it again in AF_SMC path.
>> > 
>> > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> > ---
>> > include/uapi/linux/in.h |   2 +
>> > net/smc/af_smc.c        | 129 +++++++++++++++++++++++++++++++++++++++++++++++-
>> > net/smc/inet_smc.h      |  32 ++++++++++++
>> > 3 files changed, 162 insertions(+), 1 deletion(-)
>> > create mode 100644 net/smc/inet_smc.h
>> > 
>> > diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
>> > index e682ab6..74c12e33 100644
>> > --- a/include/uapi/linux/in.h
>> > +++ b/include/uapi/linux/in.h
>> > @@ -83,6 +83,8 @@ enum {
>> > #define IPPROTO_RAW		IPPROTO_RAW
>> >    IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
>> > #define IPPROTO_MPTCP		IPPROTO_MPTCP
>> > +  IPPROTO_SMC = 263,		/* Shared Memory Communications */
>>                                                             ^ use tab to align here
>
>There is a problem here, all previous definitions were aligned with 2 spaces.

I mean the tab in the annotation in the end, not the space at the beginning.

>
>> > +#define IPPROTO_SMC		IPPROTO_SMC
>> >    IPPROTO_MAX
>> > };
>> > #endif
>> > diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> > index 1f03724..b4557828 100644
>> > --- a/net/smc/af_smc.c
>> > +++ b/net/smc/af_smc.c
>> > @@ -54,6 +54,7 @@
>> > #include "smc_tracepoint.h"
>> > #include "smc_sysctl.h"
>> > #include "smc_loopback.h"
>> > +#include "inet_smc.h"
>> > 
>> > static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
>> > 						 * creation on server
>> > @@ -3402,6 +3403,16 @@ static int smc_create(struct net *net, struct socket *sock, int protocol,
>> > 	.create	= smc_create,
>> > };
>> > 
>> Why not put those whole bunch of inet staff into smc_inet.c ?
>> Looks like your smc_inet.h is meanless without smc_inet.c
>> 
>
>This header file was originally reserved for future merging of socks. If
>nobody likes it, I can move it to the
>af_smc.c

I prefer adding a new smc_inet.c, af_smc.c is already very large.

Best regards,
Dust

>
>> > +int smc_inet_init_sock(struct sock *sk)
>> > +{
>> > +	struct net *net = sock_net(sk);
>> > +
>> > +	/* init common smc sock */
>> > +	smc_sock_init(net, sk, IPPROTO_SMC);
>> > +	/* create clcsock */
>> > +	return __smc_create_clcsk(net, sk, sk->sk_family);
>> > +}
>> > +
>> > static int smc_ulp_init(struct sock *sk)
>> > {
>> > 	struct socket *tcp = sk->sk_socket;
>> > @@ -3460,6 +3471,90 @@ static void smc_ulp_clone(const struct request_sock *req, struct sock *newsk,
>> > 	.clone		= smc_ulp_clone,
>> > };
>> > 
>> > +struct proto smc_inet_prot = {
>> > +	.name			= "INET_SMC",
>> > +	.owner			= THIS_MODULE,
>> > +	.init			= smc_inet_init_sock,
>> > +	.hash			= smc_hash_sk,
>> > +	.unhash			= smc_unhash_sk,
>> > +	.release_cb		= smc_release_cb,
>> > +	.obj_size		= sizeof(struct smc_sock),
>> > +	.h.smc_hash	= &smc_v4_hashinfo,
>> > +	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
>>                  ^
>> Align please.
>> 
>Got it.
>> > +};
>> > +
>> > +const struct proto_ops smc_inet_stream_ops = {
>> > +	.family		= PF_INET,
>> > +	.owner		= THIS_MODULE,
>> > +	.release	= smc_release,
>> > +	.bind		= smc_bind,
>> > +	.connect	= smc_connect,
>> > +	.socketpair	= sock_no_socketpair,
>> > +	.accept		= smc_accept,
>> > +	.getname	= smc_getname,
>> > +	.poll		= smc_poll,
>> > +	.ioctl		= smc_ioctl,
>> > +	.listen		= smc_listen,
>> > +	.shutdown	= smc_shutdown,
>> > +	.setsockopt	= smc_setsockopt,
>> > +	.getsockopt	= smc_getsockopt,
>> > +	.sendmsg	= smc_sendmsg,
>> > +	.recvmsg	= smc_recvmsg,
>> > +	.mmap		= sock_no_mmap,
>> > +	.splice_read	= smc_splice_read,
>> Ditto
>> 
>> > +};
>> > +
>> > +struct inet_protosw smc_inet_protosw = {
>> > +	.type       = SOCK_STREAM,
>> > +	.protocol   = IPPROTO_SMC,
>> > +	.prot   = &smc_inet_prot,
>> Ditto
>> 
>> > +	.ops    = &smc_inet_stream_ops,
>> > +	.flags  = INET_PROTOSW_ICSK,
>> > +};
>> > +
>> > +#if IS_ENABLED(CONFIG_IPV6)
>> > +struct proto smc_inet6_prot = {
>> > +	.name			= "INET6_SMC",
>> > +	.owner			= THIS_MODULE,
>> > +	.init			= smc_inet_init_sock,
>> > +	.hash			= smc_hash_sk,
>> > +	.unhash			= smc_unhash_sk,
>> > +	.release_cb		= smc_release_cb,
>> > +	.obj_size		= sizeof(struct smc_sock),
>> > +	.h.smc_hash		= &smc_v6_hashinfo,
>> > +	.slab_flags		= SLAB_TYPESAFE_BY_RCU,
>> > +};
>> > +
>> > +const struct proto_ops smc_inet6_stream_ops = {
>> > +	.family		= PF_INET6,
>> > +	.owner		= THIS_MODULE,
>> > +	.release	= smc_release,
>> > +	.bind		= smc_bind,
>> > +	.connect	= smc_connect,
>> > +	.socketpair	= sock_no_socketpair,
>> > +	.accept		= smc_accept,
>> > +	.getname	= smc_getname,
>> > +	.poll		= smc_poll,
>> > +	.ioctl		= smc_ioctl,
>> > +	.listen		= smc_listen,
>> > +	.shutdown	= smc_shutdown,
>> > +	.setsockopt	= smc_setsockopt,
>> > +	.getsockopt	= smc_getsockopt,
>> > +	.sendmsg	= smc_sendmsg,
>> > +	.recvmsg	= smc_recvmsg,
>> > +	.mmap		= sock_no_mmap,
>> > +	.splice_read	= smc_splice_read,
>> Ditto
>> 
>> > +};
>> > +
>> > +struct inet_protosw smc_inet6_protosw = {
>> > +	.type       = SOCK_STREAM,
>> > +	.protocol   = IPPROTO_SMC,
>> > +	.prot   = &smc_inet6_prot,
>> > +	.ops    = &smc_inet6_stream_ops,
>> > +	.flags  = INET_PROTOSW_ICSK,
>> Ditto
>> 
>> > +};
>> > +#endif
>> > +
>> > unsigned int smc_net_id;
>> > 
>> > static __net_init int smc_net_init(struct net *net)
>> > @@ -3595,9 +3690,28 @@ static int __init smc_init(void)
>> > 		goto out_lo;
>> > 	}
>> > 
>> > +	rc = proto_register(&smc_inet_prot, 1);
>> > +	if (rc) {
>> > +		pr_err("%s: proto_register smc_inet_prot fails with %d\n", __func__, rc);
>> > +		goto out_ulp;
>> > +	}
>> > +	inet_register_protosw(&smc_inet_protosw);
>> > +#if IS_ENABLED(CONFIG_IPV6)
>> > +	rc = proto_register(&smc_inet6_prot, 1);
>> > +	if (rc) {
>> > +		pr_err("%s: proto_register smc_inet6_prot fails with %d\n", __func__, rc);
>> > +		goto out_inet_prot;
>> > +	}
>> > +	inet6_register_protosw(&smc_inet6_protosw);
>> > +#endif
>> > +
>> > 	static_branch_enable(&tcp_have_smc);
>> > 	return 0;
>> > -
>> > +out_inet_prot:
>> > +	inet_unregister_protosw(&smc_inet_protosw);
>> > +	proto_unregister(&smc_inet_prot);
>> > +out_ulp:
>> > +	tcp_unregister_ulp(&smc_ulp_ops);
>> > out_lo:
>> > 	smc_loopback_exit();
>> > out_ib:
>> > @@ -3634,6 +3748,10 @@ static int __init smc_init(void)
>> > static void __exit smc_exit(void)
>> > {
>> > 	static_branch_disable(&tcp_have_smc);
>> > +	inet_unregister_protosw(&smc_inet_protosw);
>> > +#if IS_ENABLED(CONFIG_IPV6)
>> > +	inet6_unregister_protosw(&smc_inet6_protosw);
>> > +#endif
>> > 	tcp_unregister_ulp(&smc_ulp_ops);
>> > 	sock_unregister(PF_SMC);
>> > 	smc_core_exit();
>> > @@ -3645,6 +3763,10 @@ static void __exit smc_exit(void)
>> > 	destroy_workqueue(smc_hs_wq);
>> > 	proto_unregister(&smc_proto6);
>> > 	proto_unregister(&smc_proto);
>> > +	proto_unregister(&smc_inet_prot);
>> > +#if IS_ENABLED(CONFIG_IPV6)
>> > +	proto_unregister(&smc_inet6_prot);
>> > +#endif
>> > 	smc_pnet_exit();
>> > 	smc_nl_exit();
>> > 	smc_clc_exit();
>> > @@ -3661,4 +3783,9 @@ static void __exit smc_exit(void)
>> > MODULE_LICENSE("GPL");
>> > MODULE_ALIAS_NETPROTO(PF_SMC);
>> > MODULE_ALIAS_TCP_ULP("smc");
>> > +/* 263 for IPPROTO_SMC and 1 for SOCK_STREAM */
>> > +MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET, 263, 1);
>> > +#if IS_ENABLED(CONFIG_IPV6)
>> > +MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 263, 1);
>> > +#endif
>> > MODULE_ALIAS_GENL_FAMILY(SMC_GENL_FAMILY_NAME);
>> > diff --git a/net/smc/inet_smc.h b/net/smc/inet_smc.h
>> > new file mode 100644
>> > index 00000000..fcdcb61
>> > --- /dev/null
>> > +++ b/net/smc/inet_smc.h
>> > @@ -0,0 +1,32 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 */
>> > +/*
>> > + *  Shared Memory Communications over RDMA (SMC-R) and RoCE
>> > + *
>> > + *  Definitions for the SMC module (socket related)
>> > +
>> > + *  Copyright IBM Corp. 2016
>> You should update this.
>Got it.
>> > + *
>> > + */
>> > +#ifndef __INET_SMC
>> > +#define __INET_SMC
>> > +
>> > +#include <net/protocol.h>
>> > +#include <net/sock.h>
>> > +#include <net/tcp.h>
>> > +
>> > +extern struct proto smc_inet_prot;
>> > +extern const struct proto_ops smc_inet_stream_ops;
>> > +extern struct inet_protosw smc_inet_protosw;
>> > +
>> > +#if IS_ENABLED(CONFIG_IPV6)
>> > +#include <net/ipv6.h>
>> > +/* MUST after net/tcp.h or warning */
>> > +#include <net/transp_v6.h>
>> > +extern struct proto smc_inet6_prot;
>> > +extern const struct proto_ops smc_inet6_stream_ops;
>> > +extern struct inet_protosw smc_inet6_protosw;
>> > +#endif
>> > +
>> > +int smc_inet_init_sock(struct sock *sk);
>> > +
>> > +#endif // __INET_SMC
>>           ^
>>           use /* __INET_SMC */ instead
>> 
>> > -- 
>> > 1.8.3.1
>> > 
>

