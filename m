Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2636D25879
	for <lists+linux-s390@lfdr.de>; Tue, 21 May 2019 21:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfEUTtp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 21 May 2019 15:49:45 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:45864 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfEUTtp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 May 2019 15:49:45 -0400
Received: by mail-lj1-f171.google.com with SMTP id r76so16954861lja.12
        for <linux-s390@vger.kernel.org>; Tue, 21 May 2019 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbAeX3ULgAw+48diKoVE4ufJ3FnxC/sO5bPiY1VSwg8=;
        b=E+UYvhcXOQje8KyA+0nTfTI82/b4+Lq8UVwM13n9yGNLe15UMzG3NRe3XVXlxMmX+F
         /cjPdhV25Qyg9L7P90WLjoq2WReCfOgQK/AouRPXUOpPxsAk5RSXRQQGaiHvef/++IIv
         PUdDHUh5Plvk1f2CC0dmA8AzYpOjX9R4b/Ag4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbAeX3ULgAw+48diKoVE4ufJ3FnxC/sO5bPiY1VSwg8=;
        b=qq5Vj92cpyi+TItanc8a1NHQraShcSCRZQ6/OWZtYdahrW5WFIeD+80I1S+L2oCR0j
         PeDdaEykZmQ9xhFD1DpGI0a8zzyQ6mwQeBqe9kVDebRNXuGzkLRaLl7mtHcib1qpwqLf
         YH+vqZuN0Dj4VjZntJNwtfU0ZTF2exFBJqKe4GtVVquaKkRQdJwiyHgPpbU1GSJN4Kj+
         ZCTUkiZ1w618cQ8bDQA3fsGCnUn0TAMr1/qeURklxIZHOKcEj8tejkCQfUqBV4JZWd3s
         0yAroFCLo5/RkKnXlXjT6kxa7GTAreo3fsUX94uf+BZLxp7CQ4FuQ5tSYfW5HspjCgIU
         AFgg==
X-Gm-Message-State: APjAAAWrthJfcvFe1Q/i2ajAlVNI2LkgXXNSWB8YFZH025L3eZ5ZBgmP
        KBEkCd3krZ1cRGQ8W9u4ktmzCQejLZo=
X-Google-Smtp-Source: APXvYqz30CBVE9TW6C5F+RYC30qroxoZM1Z1A+5hYOEb0IDUdnGSHOBM825rXZHIwBGFZRcI/oKKUQ==
X-Received: by 2002:a2e:6e0b:: with SMTP id j11mr13412469ljc.46.1558468182494;
        Tue, 21 May 2019 12:49:42 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id n26sm5782303lfi.90.2019.05.21.12.49.41
        for <linux-s390@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 12:49:41 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id h11so15652156ljb.2
        for <linux-s390@vger.kernel.org>; Tue, 21 May 2019 12:49:41 -0700 (PDT)
X-Received: by 2002:a2e:6c0b:: with SMTP id h11mr7174324ljc.15.1558468181175;
 Tue, 21 May 2019 12:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190521162350.GA17107@osiris>
In-Reply-To: <20190521162350.GA17107@osiris>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 May 2019 12:49:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCtFPj_Uo1RMHnCLHut8SRG_t5M-E8Uw2+OFmc=c=H6w@mail.gmail.com>
Message-ID: <CAHk-=wgCtFPj_Uo1RMHnCLHut8SRG_t5M-E8Uw2+OFmc=c=H6w@mail.gmail.com>
Subject: Re: Sad News - Martin Schwidefsky
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 21, 2019 at 9:24 AM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> We are devastated by the tragic death of Martin Schwidefsky who died
> in an accident last Saturday.

Ouch.

Thanks for letting people know, and condolences to friends and family.

               Linus
