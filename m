Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D37D7AEC1
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jul 2019 19:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfG3Q7F (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 30 Jul 2019 12:59:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45254 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfG3Q7F (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Jul 2019 12:59:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so30147080pfq.12
        for <linux-s390@vger.kernel.org>; Tue, 30 Jul 2019 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bK/1HycOLv3l9GCBdqh/WjUXYJexoV9pk+GHZt0C6Ac=;
        b=LryUJ6aR7Ls6umLU2c0xaqBjg/o/MzlTj4417kiyq2roWEma7geN5mJxbuY/Jf00J9
         ktrdn0veTtvRLSkVpejjZUu/t5eUplpSPRh1QDfv9AutCkxbFMK72eZNn3kz68DJjXW1
         Gt4mGQFiQJb6WpCh9bTjCWVu+/2JSOQkJxIvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bK/1HycOLv3l9GCBdqh/WjUXYJexoV9pk+GHZt0C6Ac=;
        b=B+x64QqwI6nyXR53Ie8Z8vsnkgJRdGVZ5EYAZM8y79zzKUwOjVoUBPVoPPH1EWvgBq
         lZPVqdjvmYim/6KzIX6KxIkY4jcEFlc0oCLifENm4nZnrtpFHsTzZpb5n12c998wgqTA
         i2KJi8r7K+Q0psGx4anPtvm6dcb4Z2v5ZYj9CIYm8tl8gG8uTK4FGnVog85waCL9CtL1
         nhjLqt/S0s+rxfzGDnBt3ly84pxUtCky7979BPtErduCUiOT8w8482+KJ9qwSa6rQz1i
         tckLM3LyLJ3gxf5h6avTgcUWjAl8Fjzgf9VlD5FeZXZaa5G1VhT3EM+TMrr7whizXk26
         14yA==
X-Gm-Message-State: APjAAAWDxwodICzPwCt0FDotmkeWhSJ/lUmyWJYlhMP1nxnqMi0l2Yjt
        4cV43e072sI5rddxi4YwpFT9iw==
X-Google-Smtp-Source: APXvYqxNp3jr+v7rzXATnUZUI4gIf9Q+cHqz9XXDLwNPmn4kf37JvaS/4SqJ2FDMXdo0AkhOW8TXhQ==
X-Received: by 2002:a62:e901:: with SMTP id j1mr43659303pfh.189.1564505944415;
        Tue, 30 Jul 2019 09:59:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y194sm38405468pfg.116.2019.07.30.09.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jul 2019 09:59:03 -0700 (PDT)
Date:   Tue, 30 Jul 2019 09:59:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/net: Mark expected switch fall-throughs
Message-ID: <201907300959.12D21B6F09@keescook>
References: <20190730001715.GA20706@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190730001715.GA20706@embeddedor>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jul 29, 2019 at 07:17:15PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings (Building: s390):
> 
> drivers/s390/net/ctcm_fsms.c: In function ‘ctcmpc_chx_attnbusy’:
> drivers/s390/net/ctcm_fsms.c:1703:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (grp->changed_side == 1) {
>       ^
> drivers/s390/net/ctcm_fsms.c:1707:2: note: here
>   case MPCG_STATE_XID0IOWAIX:
>   ^~~~
> 
> drivers/s390/net/ctcm_mpc.c: In function ‘ctc_mpc_alloc_channel’:
> drivers/s390/net/ctcm_mpc.c:358:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (callback)
>       ^
> drivers/s390/net/ctcm_mpc.c:360:2: note: here
>   case MPCG_STATE_XID0IOWAIT:
>   ^~~~
> 
> drivers/s390/net/ctcm_mpc.c: In function ‘mpc_action_timeout’:
> drivers/s390/net/ctcm_mpc.c:1469:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if ((fsm_getstate(rch->fsm) == CH_XID0_PENDING) &&
>       ^
> drivers/s390/net/ctcm_mpc.c:1472:2: note: here
>   default:
>   ^~~~~~~
> drivers/s390/net/ctcm_mpc.c: In function ‘mpc_send_qllc_discontact’:
> drivers/s390/net/ctcm_mpc.c:2087:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (grp->estconnfunc) {
>       ^
> drivers/s390/net/ctcm_mpc.c:2092:2: note: here
>   case MPCG_STATE_FLOWC:
>   ^~~~
> 
> drivers/s390/net/qeth_l2_main.c: In function ‘qeth_l2_process_inbound_buffer’:
> drivers/s390/net/qeth_l2_main.c:328:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (IS_OSN(card)) {
>        ^
> drivers/s390/net/qeth_l2_main.c:337:3: note: here
>    default:
>    ^~~~~~~
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/s390/net/ctcm_fsms.c    | 1 +
>  drivers/s390/net/ctcm_mpc.c     | 3 +++
>  drivers/s390/net/qeth_l2_main.c | 2 +-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/ctcm_fsms.c b/drivers/s390/net/ctcm_fsms.c
> index 1b4ee570b712..4a8a5373cb35 100644
> --- a/drivers/s390/net/ctcm_fsms.c
> +++ b/drivers/s390/net/ctcm_fsms.c
> @@ -1704,6 +1704,7 @@ static void ctcmpc_chx_attnbusy(fsm_instance *fsm, int event, void *arg)
>  			grp->changed_side = 2;
>  			break;
>  		}
> +		/* Else, fall through */
>  	case MPCG_STATE_XID0IOWAIX:
>  	case MPCG_STATE_XID7INITW:
>  	case MPCG_STATE_XID7INITX:
> diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
> index e02f295d38a9..1534420a0243 100644
> --- a/drivers/s390/net/ctcm_mpc.c
> +++ b/drivers/s390/net/ctcm_mpc.c
> @@ -357,6 +357,7 @@ int ctc_mpc_alloc_channel(int port_num, void (*callback)(int, int))
>  		/*fsm_newstate(grp->fsm, MPCG_STATE_XID2INITW);*/
>  		if (callback)
>  			grp->send_qllc_disc = 1;
> +		/* Else, fall through */
>  	case MPCG_STATE_XID0IOWAIT:
>  		fsm_deltimer(&grp->timer);
>  		grp->outstanding_xid2 = 0;
> @@ -1469,6 +1470,7 @@ static void mpc_action_timeout(fsm_instance *fi, int event, void *arg)
>  		if ((fsm_getstate(rch->fsm) == CH_XID0_PENDING) &&
>  		   (fsm_getstate(wch->fsm) == CH_XID0_PENDING))
>  			break;
> +		/* Else, fall through */
>  	default:
>  		fsm_event(grp->fsm, MPCG_EVENT_INOP, dev);
>  	}
> @@ -2089,6 +2091,7 @@ static int mpc_send_qllc_discontact(struct net_device *dev)
>  			grp->estconnfunc = NULL;
>  			break;
>  		}
> +		/* Else, fall through */
>  	case MPCG_STATE_FLOWC:
>  	case MPCG_STATE_READY:
>  		grp->send_qllc_disc = 2;
> diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
> index fd64bc3f4062..cbead3d1b2fd 100644
> --- a/drivers/s390/net/qeth_l2_main.c
> +++ b/drivers/s390/net/qeth_l2_main.c
> @@ -333,7 +333,7 @@ static int qeth_l2_process_inbound_buffer(struct qeth_card *card,
>  				card->osn_info.data_cb(skb);
>  				break;
>  			}
> -			/* else unknown */
> +			/* Else, fall through */
>  		default:
>  			dev_kfree_skb_any(skb);
>  			QETH_CARD_TEXT(card, 3, "inbunkno");
> -- 
> 2.22.0
> 

-- 
Kees Cook
