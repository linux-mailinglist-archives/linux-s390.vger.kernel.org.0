Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C32BC79137
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jul 2019 18:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfG2Qj4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 29 Jul 2019 12:39:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41640 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfG2Qjz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 Jul 2019 12:39:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so18187865pgg.8
        for <linux-s390@vger.kernel.org>; Mon, 29 Jul 2019 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nb4CjHnrkOlFdXVrAOvEL/gOTXxG/KIC7AXINQV9eWk=;
        b=nlGEvZB5fX2ZSbjO+u+hA8aR3krsDKHgKYElzvXmv0PoxwN2zWeRAb4a2Brjil6QEI
         B0hYH7uYLCYxzBMwAIjS7pmNDh42vwo3hfnbAaUYvsjT0Kh5nxhMPoAwH6hY020rLd1r
         kiIA8RbrpGdG55B62jcb5KYpu2RuFV4FJczq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nb4CjHnrkOlFdXVrAOvEL/gOTXxG/KIC7AXINQV9eWk=;
        b=RrXETPfezNIw8iABLnoolFejmE/rzCMGdNmGtC4u4brPF12cRqI48zcL0LXVvc26SY
         MnX0GLpSbYkCXx7NENmtKN29A4ek1/ZZkDT+g+3LBP76US1sGIkzEI3hktVo7vbOyVvD
         tFfoiWND3MOJdrpTFCmDeVrfNBEe1R+XuvjiXbjFQvGlmTrHwVDFPd2K24xsF7WpAflW
         jEWJCGkJD7G5HWENx38qwCRFVrYa1hbFBsEWZkHxJ5jWFiyLcWeB5mCS5BagkJTq7RRG
         cm6jtgX7SUvnNXfqjKrSubJmiQqEf/NAxsJsfFYuwhDkasKe1+1g+a+IC+0bFELrHdwG
         5IAQ==
X-Gm-Message-State: APjAAAUXKUzXADumWJMQbGRHX00QY9xpYr1Z3ioei8V1tfcxb1LONSxc
        yADeKGRQpiCBju8NQAxktaVzQg==
X-Google-Smtp-Source: APXvYqyK2+iAItNJDXrCfMN9a1yOxU/cDJlsagolowGQVyJ92TnTYjA+8yIMajRcltnHr0bAJ/49qw==
X-Received: by 2002:aa7:8502:: with SMTP id v2mr36642822pfn.98.1564418395411;
        Mon, 29 Jul 2019 09:39:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x14sm79017275pfq.158.2019.07.29.09.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:39:54 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:39:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] net/af_iucv: mark expected switch fall-throughs
Message-ID: <201907290939.A3EF9B979@keescook>
References: <20190729145947.GA9494@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729145947.GA9494@embeddedor>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jul 29, 2019 at 09:59:47AM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> net/iucv/af_iucv.c: warning: this statement may fall
> through [-Wimplicit-fallthrough=]:  => 537:3, 519:6, 2246:6, 510:6
> 
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  net/iucv/af_iucv.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 09e1694b6d34..ebb62a4ebe30 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -512,7 +512,9 @@ static void iucv_sock_close(struct sock *sk)
>  			sk->sk_state = IUCV_DISCONN;
>  			sk->sk_state_change(sk);
>  		}
> -	case IUCV_DISCONN:   /* fall through */
> +		/* fall through */
> +
> +	case IUCV_DISCONN:
>  		sk->sk_state = IUCV_CLOSING;
>  		sk->sk_state_change(sk);
>  
> @@ -525,8 +527,9 @@ static void iucv_sock_close(struct sock *sk)
>  					iucv_sock_in_state(sk, IUCV_CLOSED, 0),
>  					timeo);
>  		}
> +		/* fall through */
>  
> -	case IUCV_CLOSING:   /* fall through */
> +	case IUCV_CLOSING:
>  		sk->sk_state = IUCV_CLOSED;
>  		sk->sk_state_change(sk);
>  
> @@ -535,8 +538,9 @@ static void iucv_sock_close(struct sock *sk)
>  
>  		skb_queue_purge(&iucv->send_skb_q);
>  		skb_queue_purge(&iucv->backlog_skb_q);
> +		/* fall through */
>  
> -	default:   /* fall through */
> +	default:
>  		iucv_sever_path(sk, 1);
>  	}
>  
> @@ -2247,10 +2251,10 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
>  			kfree_skb(skb);
>  			break;
>  		}
> -		/* fall through and receive non-zero length data */
> +		/* fall through - and receive non-zero length data */
>  	case (AF_IUCV_FLAG_SHT):
>  		/* shutdown request */
> -		/* fall through and receive zero length data */
> +		/* fall through - and receive zero length data */
>  	case 0:
>  		/* plain data frame */
>  		IUCV_SKB_CB(skb)->class = trans_hdr->iucv_hdr.class;
> -- 
> 2.22.0
> 

-- 
Kees Cook
