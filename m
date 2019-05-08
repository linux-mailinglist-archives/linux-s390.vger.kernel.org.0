Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE0016E42
	for <lists+linux-s390@lfdr.de>; Wed,  8 May 2019 02:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEHAa1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 7 May 2019 20:30:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37813 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfEHAa1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 May 2019 20:30:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id u3so11325737otq.4
        for <linux-s390@vger.kernel.org>; Tue, 07 May 2019 17:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNugRNfI1NASCVQQotBkfUx3cjwsiA1TzUpe8ibe7ac=;
        b=gRIeqvWjXvHVuVEemJNJK8AS0nBpMXjQNbmZV9qOtFksOrHCfrqeuX/vrn0nS6wwxy
         kLfpormJ8YBe4ZEF9hNxd/IFXkViwzDXyjJ7SWlHab5fqkWfEG9z/QESkM0GYa14N37c
         lpNEiivZk/k4qPe6YXKCt/Usic/XxFC7BwQxcRPqPZt9yKca0JFbo8LULWWrbneDHmq+
         K8a2yddzszAkKsKQ3kY36HSo7YkWplePB3l48/W53IN9tPwuJM2Yv7wbC95njLsaoego
         6jh4lLkkJ43Um5WDoj3cd+7cCVtFpC4h2yUMlngnDEfXLG3iM/uPEArsgoY53kR9Wc3H
         DUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNugRNfI1NASCVQQotBkfUx3cjwsiA1TzUpe8ibe7ac=;
        b=QBHEX9mgbF81NC9YP7PsvbIZSgrwpwvVAiGOaJbq8ASMDKEqx5TUDd3byRvME5tA2g
         k8JFfVmHV+L8cDTyf0OxxPAddy2TtvjQKvDui8QwOw1QkpT5gsn4h+29a8cCVNC8pr3M
         /XIlQsj9WuNHyOcAF/WLJSdJXa2RP0ONE8WFL3VjKh514/OakoOTW3jBjdR3FMOQIX7o
         3UnEJGxRBxBex2HTBBPPAM7SzqzZpekH5L+sisCgJEq3eLNtbz5OBwTGq+19OfhpUtOb
         +jwMZCnuOfe04acwHn3HxzqZP1K1GsfdPPi1LL/Pc65ehhNXHDUcFlLJFRrRZaSCkils
         bMJw==
X-Gm-Message-State: APjAAAXa69x6YHKTTJAVZaQI/fzB2GJGZEfodpLm2I/LvwqEJwbMBL0T
        L+B/vVbXqopLFSZ7RnGDnpSgS/b+1paBwWQDsTO/Jw==
X-Google-Smtp-Source: APXvYqwnFUcfnqP6BFgjGKomJPr5yaMMCBD85pEk3++fjkl68hk/raq4PqQ7V3ysBstXCoK7LDo9wO4kaWYzTHhnX6M=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr22059155oti.229.1557275426847;
 Tue, 07 May 2019 17:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190507183804.5512-1-david@redhat.com> <20190507183804.5512-9-david@redhat.com>
In-Reply-To: <20190507183804.5512-9-david@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 May 2019 17:30:15 -0700
Message-ID: <CAPcyv4hzpuApmKHhC6mHnE-RmiZ8Aspiv5wfd+Fs4QmaDsCJVw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] mm/memory_hotplug: Remove "zone" parameter from sparse_remove_one_section
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 7, 2019 at 11:39 AM David Hildenbrand <david@redhat.com> wrote:
>
> Unused, and memory unplug path should never care about zones. This is
> the job of memory offlining. ZONE_DEVICE might require special care -
> the caller of arch_remove_memory() should handle this.

The ZONE_DEVICE usage does not require special care so you can drop
that comment. The only place it's used in the subsection patches is to
lookup the node-id, but it turns out that the resulting node-id is
then never used.

With the ZONE_DEVICE mention dropped out of changelog you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
