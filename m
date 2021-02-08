Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDF53132EB
	for <lists+linux-s390@lfdr.de>; Mon,  8 Feb 2021 14:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBHNHt (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 8 Feb 2021 08:07:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54957 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhBHNHn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Feb 2021 08:07:43 -0500
Received: from mail-ot1-f69.google.com ([209.85.210.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1l96Fo-0001E1-74
        for linux-s390@vger.kernel.org; Mon, 08 Feb 2021 13:07:00 +0000
Received: by mail-ot1-f69.google.com with SMTP id z2so8412697otk.1
        for <linux-s390@vger.kernel.org>; Mon, 08 Feb 2021 05:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2jyNwMfMvGFj0tInT8gBtuOq2OaW/TH0BzhuFrJk/sE=;
        b=ZKLhXhQk4VmmtZhMH6tNyDrIOGNGjv1eVTtmWHQ4G0SAK97I8udI0aLaxX2/8ScvjY
         rytoPW+zKwEJMmpWre86PQGMfHSbMLKV+7F1ENenERHd7dtVvpYRj2tYik2+CMyrNSiM
         uO5XfwNdl7LM4vLB/pPq68LJr+xZHm3DLC5B+AxUm5Q2N1j6JRVyRT6o0xC5nyeBGiKX
         KPcqYbG/Vg1nulQjGrAYhh33qH+19v6IyNB5cS2ELbuiWyvMqlYzpwxomdNL7arWUBj7
         gdhRsvlxNML9jH68FJH2fPxhC6QuEb1VCdH5qXQS9RZAPYym8WQYqZb/n5JpYyBX3LCY
         AFuA==
X-Gm-Message-State: AOAM530AvxXVlE+6gAytbgAn4p8nvDf9cMecmPqOGqYKVjXfXq6HZq+l
        2j4xL1eC9suGPyTz468lsncRSjCeeosPKci3MuBRnK/iMQCd4mbQ2yyeTk9EqjE9BwbZm0S5pUM
        D2cA8X2VLf5FQJf6xYJU1LHCNgdvghUGvmFDMQJo=
X-Received: by 2002:a54:4e87:: with SMTP id c7mr11063586oiy.94.1612789619276;
        Mon, 08 Feb 2021 05:06:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRZeY0ZgzJd40eVlSquuFWx61fEHWiKNwJ0we6wRvo/juRBPingMvoqMvDfntq4b4qnxDZ4w==
X-Received: by 2002:a54:4e87:: with SMTP id c7mr11063564oiy.94.1612789619070;
        Mon, 08 Feb 2021 05:06:59 -0800 (PST)
Received: from localhost ([136.37.150.243])
        by smtp.gmail.com with ESMTPSA id w10sm3626511oih.8.2021.02.08.05.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 05:06:58 -0800 (PST)
Date:   Mon, 8 Feb 2021 07:06:58 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Chris Down <chris@chrisdown.name>,
        Amir Goldstein <amir73il@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: Disallow CONFIG_TMPFS_INODE64 on s390
Message-ID: <YCE3cjDNOvpeCCeA@ubuntu-x1>
References: <20210205230620.518245-1-seth.forshee@canonical.com>
 <20210207144831.lsrm74ypbz7i37uz@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207144831.lsrm74ypbz7i37uz@box>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, Feb 07, 2021 at 05:48:31PM +0300, Kirill A. Shutemov wrote:
> On Fri, Feb 05, 2021 at 05:06:20PM -0600, Seth Forshee wrote:
> > This feature requires ino_t be 64-bits, which is true for every
> > 64-bit architecture but s390, so prevent this option from being
> > selected there.
> 
> Quick grep suggests the same for alpha. Am I wrong?

No, it appears you are right. Looks like my grep missed alpha somehow.

Andrew, do you prefer an additional patch or an updated version of the
previous patch?
