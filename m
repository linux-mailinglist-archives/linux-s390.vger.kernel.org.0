Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80FCA966A9
	for <lists+linux-s390@lfdr.de>; Tue, 20 Aug 2019 18:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfHTQnK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 20 Aug 2019 12:43:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44184 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfHTQnK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Aug 2019 12:43:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so3543368pgl.11
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 09:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LW7Np807JFXBPdceTJ4YMsWPKJJt2VUoFPmk4EchDJ4=;
        b=DWqUjz7Sz+yih0xqXpFkLQQ+CT2h4rbqyp0wKeHt+Z+oShWylBFZCeBctZctW/ngYJ
         1SPSJLyrMZYEwVvyG44ztncLLIps7lRlirLfaZw2mO7qnEmIUim2OD8Ixm1iyf1LZtBM
         Mbg24jOgm+1m4/qq1oHyp2QW0qeR+qCDbK8yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LW7Np807JFXBPdceTJ4YMsWPKJJt2VUoFPmk4EchDJ4=;
        b=e19KSRUZxOnRK5zj2zUPdA9dvX8hOQKvmtH62H9dz2F0hyuqbKovx4YSrVWKMRr+Yd
         LPtqScqMyolaHPLuETkssUjtqw8lSc9CfW/CueO2HgUQYg5Vl2/VeBB3raOV9Rh1mons
         W3sYtjE3EgwdgewwN/MUfCKrJQOQ5GIGbcjwnWGDZHZo7/8MdcfWpppvxHFRM/MyaBrP
         y9x7VNUBxgwojIBg5LjCYdSjFa4YpqZWql/HAl/t8Yrf1seTrDYkKkn6JeLcLHd+GrFs
         +HCzYf4SBsXamb0LvLAtCtT8tn2+XDcvKYtxW9EmxplRfcLsi16VxC1Vmst3YbG9ZxSi
         LbMg==
X-Gm-Message-State: APjAAAXJKoyocj/vXKK3N6buckDWg1IF72PB+Fi93ZzLytrnvpt/smkR
        mTAo2tHaV8KaWDWa3j7Z/e0MhA==
X-Google-Smtp-Source: APXvYqzvd+GzbIYYqMRO7YhQ4o8RQrhpByuzytC05pNE/nDMOXLzSTZujG3Dk1gGvv6drTwyXCh4KQ==
X-Received: by 2002:a63:8f55:: with SMTP id r21mr25426981pgn.318.1566319389424;
        Tue, 20 Aug 2019 09:43:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u69sm23851408pgu.77.2019.08.20.09.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 09:43:08 -0700 (PDT)
Date:   Tue, 20 Aug 2019 09:43:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     jwi@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [bug report] s390/qeth: streamline SNMP cmd code
Message-ID: <201908200941.93D8BB7B@keescook>
References: <20190820110504.GA1847@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820110504.GA1847@mwanda>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 20, 2019 at 02:05:04PM +0300, Dan Carpenter wrote:
> [  Kees, could we make copy_from_user() just fail if size is more than
>    INT_MAX? ]

We already have similar limits in the VFS and other helpers. We might as
well do it in copy_*_user() too. Let me put together a patch...

-Kees

> 
> Hello Julian Wiedmann,
> 
> The patch d4c08afafa04: "s390/qeth: streamline SNMP cmd code" from
> Jun 27, 2019, leads to the following static checker warning:
> 
> 	drivers/s390/net/qeth_core_main.c:4381 qeth_snmp_command()
> 	error: check that 'req_len' is capped
> 
> drivers/s390/net/qeth_core_main.c
>   4355  static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
>   4356  {
>   4357          struct qeth_snmp_ureq __user *ureq;
>   4358          struct qeth_cmd_buffer *iob;
>   4359          unsigned int req_len;
>   4360          struct qeth_arp_query_info qinfo = {0, };
>   4361          int rc = 0;
>   4362  
>   4363          QETH_CARD_TEXT(card, 3, "snmpcmd");
>   4364  
>   4365          if (IS_VM_NIC(card))
>   4366                  return -EOPNOTSUPP;
>   4367  
>   4368          if ((!qeth_adp_supported(card, IPA_SETADP_SET_SNMP_CONTROL)) &&
>   4369              IS_LAYER3(card))
>   4370                  return -EOPNOTSUPP;
>   4371  
>   4372          ureq = (struct qeth_snmp_ureq __user *) udata;
>   4373          if (get_user(qinfo.udata_len, &ureq->hdr.data_len) ||
>   4374              get_user(req_len, &ureq->hdr.req_len))
>   4375                  return -EFAULT;
>   4376  
>   4377          iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL, req_len);
> 
> The problem is that qeth_get_adapter_cmd() doesn't guard against integer
> overflows if reg_len is >= UINT_MAX - offsetof(struct qeth_ipacmd_setadpparms,
> data)).
> 
>   4378          if (!iob)
>   4379                  return -ENOMEM;
>   4380  
>   4381          if (copy_from_user(&__ipa_cmd(iob)->data.setadapterparms.data.snmp,
>   4382                             &ureq->cmd, req_len)) {
> 
> So then this copy_from_user() could overflow.  The original code had a
> similar problem but it only affect 32 bit systems.  I'm not sure what is
> a good upper bound for req_len.
> 
>   4383                  qeth_put_cmd(iob);
>   4384                  return -EFAULT;
>   4385          }
>   4386  
>   4387          qinfo.udata = kzalloc(qinfo.udata_len, GFP_KERNEL);
> 
> regards,
> dan carpenter

-- 
Kees Cook
