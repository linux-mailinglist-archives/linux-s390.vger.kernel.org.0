Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFBEF11FAB1
	for <lists+linux-s390@lfdr.de>; Sun, 15 Dec 2019 20:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfLOTQC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 15 Dec 2019 14:16:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44774 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfLOTQB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 15 Dec 2019 14:16:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id az3so3487451plb.11
        for <linux-s390@vger.kernel.org>; Sun, 15 Dec 2019 11:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=xFfFWWdC/bnsdcTQa3y8hEjF2m53IxR9gV68m2FvqOs=;
        b=YJQ+a3m+rMoCZ9Ljew50T1AmciTwSCpouovZXEra7BzF3yyVwRqcE6K0OrSo4iczKy
         FKJl5QhEUDYFJhJxv7Ymq0S+oXD65ecrzmzMGBKaX1GAf37E7SkOuf1wrtkO3KXz5dPT
         CiBhAvg6xvt55+bX9qpVfGE/jmjw9Xtq1jBShq/d4U9wHEJUTzo3OLKeuSG76zW7e7XV
         /gfoYW2WdK6Ep8ReHS8Q2uq2Ff7nNtGapkEcbJn/NkK8B3nqlO/QoyMoGxcGsaGFPxsn
         v0q5ItTE2RBYxu14VugRie0HJEHx9DxXUX3Ke51tavfRmteYYl8uKcdrvMk3tMgmbkKx
         Zu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=xFfFWWdC/bnsdcTQa3y8hEjF2m53IxR9gV68m2FvqOs=;
        b=QgPyyWr9EglojjUbwxEKTYFl028KAKxhq9/3FH0ux5qdA2u/rpg0UdKVjTGokh2Mmf
         nofku2/VmjJ48Q/SDiGz2rsQ9a4ZC3RzdBkeEf0/SOt8RAV//ZtaXrmnihA3GyD3wFdK
         mw87VwbtNuhB4e43B1FvEH2J1nvtYfkV2KQyRPZOcnYmoXNuVgYjj14GtYczUiF+b8+w
         HAv8x7r6TVD9O0WBpZiK0WikXqKAMsb/k183VcG1iqRWpqWq8zQMUzGdUyCouO8d5zFf
         Whq14fDaLH4VwqHXeYZMjoy3Uetv1CYVG8SMi2KLa7hahb9lmcmSCo9MBUC6sP6lw7xS
         CPsw==
X-Gm-Message-State: APjAAAX1O1GBWqqIuB2Rg44ssyyhqdMQJMnPYjDoatErteMWQH+iDIEB
        b71xXPlOCeOsD8pGd8I6h9oiAw==
X-Google-Smtp-Source: APXvYqysBvuDqIOYkKuPoop7EVPuDHYGQEncJFVqjHJ/boW9QneFrQOgYC9mNwC5OFp2ftlmYgAv0w==
X-Received: by 2002:a17:902:43:: with SMTP id 61mr12329671pla.88.1576437361023;
        Sun, 15 Dec 2019 11:16:01 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id h68sm20556537pfe.162.2019.12.15.11.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 11:16:00 -0800 (PST)
Date:   Sun, 15 Dec 2019 11:15:58 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Karsten Graul <kgraul@linux.ibm.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, ubraun@linux.ibm.com
Subject: Re: [PATCH net] net/smc: add fallback check to connect()
Message-ID: <20191215111558.57dfdcf9@cakuba.netronome.com>
In-Reply-To: <20191212213558.10564-1-kgraul@linux.ibm.com>
References: <20191212213558.10564-1-kgraul@linux.ibm.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 12 Dec 2019 22:35:58 +0100, Karsten Graul wrote:
> From: Ursula Braun <ubraun@linux.ibm.com>
> 
> FASTOPEN setsockopt() or sendmsg() may switch the SMC socket to fallback
> mode. Once fallback mode is active, the native TCP socket functions are
> called. Nevertheless there is a small race window, when FASTOPEN
> setsockopt/sendmsg runs in parallel to a connect(), and switch the
> socket into fallback mode before connect() takes the sock lock.
> Make sure the SMC-specific connect setup is omitted in this case.
> 
> This way a syzbot-reported refcount problem is fixed, triggered by
> different threads running non-blocking connect() and FASTOPEN_KEY
> setsockopt.
> 
> Reported-by: syzbot+96d3f9ff6a86d37e44c8@syzkaller.appspotmail.com
> Fixes: 6d6dd528d5af ("net/smc: fix refcount non-blocking connect() -part 2")
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Applied, and queued for stable, thank you!
