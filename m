Return-Path: <linux-s390+bounces-539-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC3A8107D1
	for <lists+linux-s390@lfdr.de>; Wed, 13 Dec 2023 02:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4900C28219F
	for <lists+linux-s390@lfdr.de>; Wed, 13 Dec 2023 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAC5A5E;
	Wed, 13 Dec 2023 01:48:58 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B984CAD;
	Tue, 12 Dec 2023 17:48:53 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyO3miM_1702432130;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0VyO3miM_1702432130)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 09:48:51 +0800
Date: Wed, 13 Dec 2023 09:48:47 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
To: Ahelenia =?us-ascii?Q?Ziemia'nska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Karsten Graul <kgraul@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 06/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
Message-ID: <ZXkNf9vvtzR7oqoE@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>

Please add correct tag, for this patch, IIUC, it should be a fix, and
you need add [PATCH net].

On Tue, Dec 12, 2023 at 11:12:47AM +0100, Ahelenia Ziemia'nska wrote:
> Otherwise we risk sleeping with the pipe locked for indeterminate
> lengths of time.
> 
> Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u

Fixes line is needed.

> Signed-off-by: Ahelenia Ziemia'nska <nabijaczleweli@nabijaczleweli.xyz>
> ---
>  net/smc/af_smc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index bacdd971615e..89473305f629 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -3243,12 +3243,8 @@ static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
>  			rc = -ESPIPE;
>  			goto out;
>  		}
> -		if (flags & SPLICE_F_NONBLOCK)
> -			flags = MSG_DONTWAIT;
> -		else
> -			flags = 0;
>  		SMC_STAT_INC(smc, splice_cnt);
> -		rc = smc_rx_recvmsg(smc, NULL, pipe, len, flags);
> +		rc = smc_rx_recvmsg(smc, NULL, pipe, len, MSG_DONTWAIT);
>  	}
>  out:
>  	release_sock(sk);
> -- 
> 2.39.2



