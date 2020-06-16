Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B157B1FAE05
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2020 12:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgFPKcO (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 16 Jun 2020 06:32:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45458 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728259AbgFPKcM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 06:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592303509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=SdADszuEQb5NkFtZn165E2elxy5Z9GcLont1/bpaTkQ=;
        b=iCj0W13ECSkCd9gl3FNdspTXLptPzi9PgeVYpvA6rss3wrGLCMzE7nKWamEp+tSl3joXq2
        E23KduuGx5hVxtGkM5JpC0iqsBJP8/rgB1osE+CfqGv4qx6p3GXFFDUACq2zghwpO4inDD
        AXHExcm8DEiUBp2dfRkPqZws0KJO110=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-yhjicgX5P_yZxdS7jznMug-1; Tue, 16 Jun 2020 06:31:47 -0400
X-MC-Unique: yhjicgX5P_yZxdS7jznMug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ED171091332;
        Tue, 16 Jun 2020 10:31:46 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-128.ams2.redhat.com [10.36.114.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A6126EDBE;
        Tue, 16 Jun 2020 10:31:41 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v9 09/12] s390x: Library resources for CSS
 tests
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-10-git-send-email-pmorel@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c424e6fe-a2f1-65fe-7ed1-2f26bc58587c@redhat.com>
Date:   Tue, 16 Jun 2020 12:31:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1592213521-19390-10-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 15/06/2020 11.31, Pierre Morel wrote:
> Provide some definitions and library routines that can be used by
> tests targeting the channel subsystem.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/css.h      | 256 +++++++++++++++++++++++++++++++++++++++++++
>  lib/s390x/css_dump.c | 153 ++++++++++++++++++++++++++
>  s390x/Makefile       |   1 +
>  3 files changed, 410 insertions(+)
>  create mode 100644 lib/s390x/css.h
>  create mode 100644 lib/s390x/css_dump.c

I can't say much about the gory IO details, but at least the inline
assembly looks fine to me now.

Acked-by: Thomas Huth <thuth@redhat.com>

