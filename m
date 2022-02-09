Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78864AEDE1
	for <lists+linux-s390@lfdr.de>; Wed,  9 Feb 2022 10:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiBIJWj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 9 Feb 2022 04:22:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiBIJWi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Feb 2022 04:22:38 -0500
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82E8E053F88;
        Wed,  9 Feb 2022 01:22:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V4-nGVb_1644398213;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0V4-nGVb_1644398213)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 17:16:54 +0800
Date:   Wed, 9 Feb 2022 17:16:51 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     "D. Wythe" <alibuda@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, kuba@kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v5 5/5] net/smc: Add global configure for auto
 fallback by netlink
Message-ID: <YgOGg9Ud5N7LOOV6@TonyMac-Alibaba>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <cover.1644323503.git.alibuda@linux.alibaba.com>
 <f54ee9f30898b998edf8f07dabccc84efaa2ab8b.1644323503.git.alibuda@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f54ee9f30898b998edf8f07dabccc84efaa2ab8b.1644323503.git.alibuda@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Feb 08, 2022 at 08:53:13PM +0800, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> @@ -248,6 +248,8 @@ int smc_nl_get_sys_info(struct sk_buff *skb, struct netlink_callback *cb)
>  		goto errattr;
>  	if (nla_put_u8(skb, SMC_NLA_SYS_IS_SMCR_V2, true))
>  		goto errattr;
> +	if (nla_put_u8(skb, SMC_NLA_SYS_AUTO_FALLBACK, smc_auto_fallback))

READ_ONCE(smc_auto_fallback) ?

> +		goto errattr;
>  	smc_clc_get_hostname(&host);
>  	if (host) {
>  		memcpy(hostname, host, SMC_MAX_HOSTNAME_LEN);
> diff --git a/net/smc/smc_netlink.c b/net/smc/smc_netlink.c
> index f13ab06..a7de517 100644
> --- a/net/smc/smc_netlink.c
> +++ b/net/smc/smc_netlink.c
> @@ -111,6 +111,16 @@
>  		.flags = GENL_ADMIN_PERM,
>  		.doit = smc_nl_disable_seid,
>  	},
> +	{
> +		.cmd = SMC_NETLINK_ENABLE_AUTO_FALLBACK,
> +		.flags = GENL_ADMIN_PERM,
> +		.doit = smc_enable_auto_fallback,
> +	},
> +	{
> +		.cmd = SMC_NETLINK_DISABLE_AUTO_FALLBACK,
> +		.flags = GENL_ADMIN_PERM,
> +		.doit = smc_disable_auto_fallback,
> +	},
>  };

Consider adding the separated cmd to query the status of this config,
just as SEID does?

It is common to check this value after user-space setted. Combined with
sys_info maybe a little heavy in this scene.

Thanks,
Tony Lu
