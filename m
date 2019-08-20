Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0533895BBC
	for <lists+linux-s390@lfdr.de>; Tue, 20 Aug 2019 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfHTJ4J (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 20 Aug 2019 05:56:09 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44539 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbfHTJ4J (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Aug 2019 05:56:09 -0400
Received: by mail-oi1-f194.google.com with SMTP id k22so3615422oiw.11
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERy6C+OfX7AwXRit4NjtghifEuheVTJjPNjjGxnVXl4=;
        b=esBS8tvWjvw1oPPxWdzyE63jd94MRLnrUUg4cyouQEMyiYTKxPG+Md74XSdR0Hn9qm
         u/yhAcDom21n1PFzSKCGDVRlC8bwdtOPV5Ga016Y3MfIx+qPtgAqq/l3ZdPMYmiQU647
         6FOJ9xi1gsNq3LaPCHCLn+mUPV3cg7lHqbwFZk1uSrWhaPoT1t9n6MR3QtZbKyLxDSxS
         yOOtBByzrdAPB/lhM3CHw0IMUBqHOuId43QVT2RwUl/2EzvVgf27h3OlZL30SdLIkmOF
         KUilJjflda9G5h40sZPfyzC1FSzsAn8yoWXinP1SG4qMRUqYupzKNJdNoA/N8PfONPNJ
         u4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERy6C+OfX7AwXRit4NjtghifEuheVTJjPNjjGxnVXl4=;
        b=lZMPn8gG6xta3cgchiUF3VHZ3xVUnBErZNicknqVaeP3Hg3WnheDtIweFLlhD7Bao4
         9EOyQ7hDvgVVu3MtDOIn1d2DQK+1uT/ddoFXRlOt5MGCEijxen0MjLk4znye68ImNmJD
         bnGssITgddCzOopcbDdlZtcdEhc98c0KkigCS4Ig9SuxPslq8kUOxjW7dAaxqqM5Wevq
         sjEsrYlYT2gYY2KFHxffu3mmfKgeNM64rxZnFja27uTz+Xn6SebI0u23YPfsiVJKTjnj
         aRT3UZWKx/U359ib4z0mue4F2DpQGVS97FfrIXKQEvtfHlQVEB4jBpjBdlTUtVJEsfxp
         zoNg==
X-Gm-Message-State: APjAAAWCeIjv6ep3alKRwaHbaipMz7jlMTxX72zLRvct+qmKTXddKZ/n
        yiRFZTqrLB6L1iYFZdnOgIuemYUsK247glj6EJjuAA==
X-Google-Smtp-Source: APXvYqyQ6eoEoVcpR/xbV96cbSTy0dNPpLdj0gQt1oJ++FGqgDPc8X6DViRqQ8kizDCDO6cg+XdDCeC8PkqVTf9p8Pg=
X-Received: by 2002:aca:c396:: with SMTP id t144mr11367178oif.172.1566294967836;
 Tue, 20 Aug 2019 02:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190820024941.12640-1-dja@axtens.net>
In-Reply-To: <20190820024941.12640-1-dja@axtens.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 20 Aug 2019 11:55:56 +0200
Message-ID: <CANpmjNMpBAjX4G2GYmM6-z8TfXdbzLCuAMQ-fmGRwEDFMci4Ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kasan: support instrumented bitops combined with
 generic bitops
To:     Daniel Axtens <dja@axtens.net>
Cc:     christophe.leroy@c-s.fr, linux-s390@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 20 Aug 2019 at 04:50, Daniel Axtens <dja@axtens.net> wrote:
>
> Currently bitops-instrumented.h assumes that the architecture provides
> atomic, non-atomic and locking bitops (e.g. both set_bit and __set_bit).
> This is true on x86 and s390, but is not always true: there is a
> generic bitops/non-atomic.h header that provides generic non-atomic
> operations, and also a generic bitops/lock.h for locking operations.
>
> powerpc uses the generic non-atomic version, so it does not have it's
> own e.g. __set_bit that could be renamed arch___set_bit.
>
> Split up bitops-instrumented.h to mirror the atomic/non-atomic/lock
> split. This allows arches to only include the headers where they
> have arch-specific versions to rename. Update x86 and s390.
>
> (The generic operations are automatically instrumented because they're
> written in C, not asm.)
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Acked-by: Marco Elver <elver@google.com>

Thanks!
