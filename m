Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C5C185989
	for <lists+linux-s390@lfdr.de>; Sun, 15 Mar 2020 04:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCODCS (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 14 Mar 2020 23:02:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51601 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726738AbgCODCR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 14 Mar 2020 23:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584241336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hbJyE5xwqVIitBkS3hnaFSQEPHc+aUC/LLikTGDcmKs=;
        b=S94BnV/UIoxjzKinNnEqRI5+MC3WJat3/lUHUPcg9hznd/nnyOESAfLhtIka5rIi/FvDLw
        ID/cOMA6iVDgD9iE9vB9mfvmTvM6t75CkpknPcqRPUHudPLaSXqGUTFznzWhXcTGOM9M0v
        wyXPJkiiPn75B4KU51sIB5yz9M7koUo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-NDHujXeAOIuOzxT3bF_VjQ-1; Sat, 14 Mar 2020 06:59:36 -0400
X-MC-Unique: NDHujXeAOIuOzxT3bF_VjQ-1
Received: by mail-wr1-f69.google.com with SMTP id o9so5799146wrw.14
        for <linux-s390@vger.kernel.org>; Sat, 14 Mar 2020 03:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hbJyE5xwqVIitBkS3hnaFSQEPHc+aUC/LLikTGDcmKs=;
        b=FNjnxKST1uPHHNf3+9ps9MHs9I8g8wYM98vEZ31XbTpzGh+iAJaLpgghN8Z6y0zmv3
         Y89VAPTRYW8g8lcESeNDwlfcTA4wgEBcI2S7/K8p6jX5INEqaiWl8ZyHBN6Bd90Kgn0M
         KfbF4OPtXB7AcTVGryzW5PukkZLY2PvAMgO73GGfXDSWYtCZVPibt3WgyEZmWFk67dbf
         GMBR/hrqfc/jAN+jLNeXlXerJPUApGW3FTqclg20N/TVY6HC82uu3HYNl5mKScEZtLj4
         YMUXtC52JBApNh2AYXOj84KpVQqkp6N/anv40B0XtNSBmccnczpx4q4zwffVYCDJqrMP
         XFZA==
X-Gm-Message-State: ANhLgQ3Y610tt9DCYQVX6dBCDnyaBi4oB8OaS5lCgk6ldh7a4U3LSXKD
        JJHT1MEc4w5MD1CuhQZ0G1icmXcVTSDw1LFzDASeeq6aFoIhFqjutOGFceS1UNqFMFGYVm1phSD
        +NhmkdQ58iUZNUDdQzuYMyQ==
X-Received: by 2002:adf:e906:: with SMTP id f6mr23599860wrm.108.1584183575491;
        Sat, 14 Mar 2020 03:59:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsxB384LhhFaGJTP6mS6+dEUF5GBh32yBpthvK6EtaJT62jRn7oFwehdv3+6f/b7HUvw33Tig==
X-Received: by 2002:adf:e906:: with SMTP id f6mr23599849wrm.108.1584183575311;
        Sat, 14 Mar 2020 03:59:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7de8:5d90:2370:d1ac? ([2001:b07:6468:f312:7de8:5d90:2370:d1ac])
        by smtp.gmail.com with ESMTPSA id y200sm18937265wmc.20.2020.03.14.03.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2020 03:59:34 -0700 (PDT)
Subject: Re: [GIT PULL 0/1] KVM: s390: Fix for 5.6
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <20200312142750.3603-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8b0298c5-c040-e5b6-aea5-4170f3152ef7@redhat.com>
Date:   Sat, 14 Mar 2020 11:59:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312142750.3603-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/03/20 15:27, Christian Borntraeger wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.6-1

Pulled, thanks.

Paolo

